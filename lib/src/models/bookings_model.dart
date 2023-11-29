import 'package:hello_angel/src/models/calendar_model.dart';
import 'package:hello_angel/src/schemas/bookings_schema.dart';
import 'package:hello_angel/src/schemas/resource_schema.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';
import 'package:uuid/uuid.dart';

/**
 * Model de Reservas
 */

class BookingModel {
  static Future getAllBookings(PostgresConnection connection) async {
    var result = await connection.query({
      'query': "SELECT * FROM reserva;",
      'params': {"": ""}
    });
    return (result['error'] != null)
        ? {
            "status": 400,
            "message": "Error al conectar con la base de datos",
            "data": []
          }
        : {"status": 200, "message": "", "data": result["data"]};
  }

  static Future getBookingsByResource(
      PostgresConnection connection, var params) async {
    var result = await validateParamsResource(params);
    if (result.errors.isEmpty) {
      var resultquery = await connection.query({
        'query':
            "SELECT * FROM reserva where lower(idrecursopkfk) = lower(@idRecurso) and lower(idtiporecursopkfk) = lower(@idTipoR) ;",
        'params': result.data
      });
      return (resultquery['error'] != null)
          ? {
              "status": 400,
              "message": "Error al conectar con la base de datos",
              "data": null
            }
          : {"status": 200, "message": "", "data": resultquery["data"]};
    }
    return {"status": 400, "message": result.errors.toString(), "data": []};
  }

  static Future getBookingById(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "SELECT * FROM reserva where lower(idReserva) = lower(@idReserva)",
      'params': params
    });
    (result['error'] != null)
        ? {
            "status": 400,
            "message": "Error al conectar con la base de datos",
            "data": []
          }
        : {"status": 200, "message": "", "data": result["data"]};
  }

  static Future getBookingByIdUser(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "SELECT * FROM reserva where lower(idusuariopkfk) = lower(@idUsuario)",
      'params': params
    });
    return (result['error'] != null)
        ? {
            "status": 400,
            "message": "Error al conectar con la base de datos",
            "data": []
          }
        : {"status": 200, "message": "", "data": result["data"]};
  }

  static Future getBookingByStatus(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query': "SELECT * FROM reserva where lower(idestado) = lower(@idEstado)",
      'params': params
    });
    return (result['error'] != null)
        ? {
            "status": 400,
            "message": "Error al conectar con la base de datos",
            "data": null
          }
        : {"status": 200, "message": "", "data": result["data"]};
  }

  static Future getBookingByUserAndStatus(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "SELECT * FROM reserva where lower(idusuariopkfk) = lower(@idUsuario) and lower(idestado) = lower(@idEstado)",
      'params': params
    });
    return (result['error'] != null)
        ? {
            "status": 400,
            "message": "Error al conectar con la base de datos",
            "data": null
          }
        : {"status": 200, "message": "", "data": result["data"]};
  }

  static Future createBooking(PostgresConnection connection, var params) async {
    var result = await validateParamsBooking(params); // validar los datos
    if (result.errors.isEmpty) {
      // si no hay errores
      var bookings = await BookingModel.getBookingByUserAndStatus(connection, {
        'idUsuario': result.data['idUsuario'],
        'idEstado': result.data['idEstado']
      }); // buscar las reservas que tengan el mismo usuario activas
      if (bookings['status'] == 200 && bookings['data'].length < 5) {
        // si hay menos de 5 reservas activas se crea una reserva
        Map<String, dynamic> data = {};
        result.data.forEach((key, value) {
          data.addAll({key: value});
        });
        data.addAll({'idReserva': Uuid().v1()});
        // si no hay error se crea la reserva
        var queryI = await connection.query({
          'query':
              "INSERT INTO reserva VALUES (@idReserva,@idUsuario,@idRecurso,@idTipoR,@idEstado);",
          'params': data
        });
        if (queryI['error'] == null) {
          // si no hay error se crea el calendario
          var calendar = await CalendarModel.createCalendar(connection, data);
          if (calendar['status'] == 400) {
            await BookingModel.deleteBooking(connection, data);
            return {"status": 400, "message": calendar['message'], data: []};
          }
          return {
            "status": 201,
            "message": "Se ha creado la reserva",
            "data": []
          };
        }
        return {
          "status": 400,
          "message": "Error al crear la reserva",
          "data": []
        };
      }
      return (bookings['errors'] != null)
          ? {
              "status": 400,
              "message": "Error al conectar con la base de datos",
              "data": []
            }
          : {
              "status": 400,
              "message": "Ya tiene el maximo de reservas activas",
              "data": []
            };
    }
    return {"status": 400, "message": result.errors.toString()};
  }

  static Future deleteBooking(PostgresConnection connection, var params) async {
    var validate = await validateParamsDeleteBooking(params);
    if (validate.errors.isEmpty) {
      var resultCalendar = await CalendarModel.deleteCalendarByBookings(
          connection, validate.data);
      if (resultCalendar['status'] == 200) {
        var result = await connection.query({
          'query':
              "DELETE FROM reserva where lower(idreserva) = lower(@idReserva)",
          'params': validate.data
        });
        return (result['error'] != null)
            ? {
                "status": 400,
                "message": "Error al conectar con la base de datos",
                "data": null
              }
            : {
                "status": 200,
                "message": "Se borro la reserva",
                "data": result["data"]
              };
      }
      return {"status": 400, "message": resultCalendar['message'], "data": []};
    }
    return {"status": 400, "message": validate.errors.toString(), "data": []};
  }

  static Future updateStateBooking(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "Update reserva set idestado = @idEstado where lower(idreserva) = lower(@idReserva)",
      'params': params
    });
    return (result['error'] != null)
        ? {
            "status": 400,
            "message": "Error al conectar con la base de datos",
            "data": []
          }
        : {
            "status": 200,
            "message": "Se actualizo el estado de la reserva",
            "data": result["data"]
          };
  }
}
