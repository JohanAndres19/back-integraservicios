import 'package:hello_angel/src/models/calendar_model.dart';
import 'package:hello_angel/src/schemas/bookings_schema.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';
import 'package:uuid/uuid.dart';

/**
 * Model de Reservas
 */

class BookingModel {

  static Future getAllBookings(PostgresConnection connection) async{
    var result = await connection.query({
      'query': "SELECT * FROM reserva;",
      'params': {"": ""}
    });
    return (result['error'] != null)
        ? {
            "status": 400,
            "message": "Error al conectar con la base de datos",
            "data": null
          }
        : {"status": 200, "message": "", "data": result["data"]};

  } 
  static Future getBookingsByResource(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "SELECT * FROM reserva where lower(idrecursopkfk) = lower(@idRecurso) and lower(idtiporecursopkfk) = lower(@idTipo) ;",
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
            "data": null
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
            "data": null
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

  static Future createBooking(PostgresConnection connection, var params) async {
    var result = await validateParamsBooking(params); // validar los datos
    if (result.errors.isEmpty) {
      // si no hay errores
      var bookings = await BookingModel.getBookingByIdUser(connection, {
        'idUsuario': result.data['idUsuario']
      }); // buscar las reservas que tengan el mismo usuario
      var bookingsActivo = (bookings['error'] == null)
          ? bookings['data']
              .where((element) => element['reserva']['idEstado'] == 'activo')
              .length
          : -1; // contar las reservas activas si no hay errores
      if (bookingsActivo < 5 && bookingsActivo != -1) {
        // si hay menos de 5 reservas activas se crea una reserva
        result.data.addAll({'idReserva': Uuid().v1()});
        var calendar = await CalendarModel.createCalendar(
            connection, result.data); // crear el calendario
        if (calendar['status'] == 201) {
          // si no hay error se crea la reserva
          await connection.query({
            'query':
                "INSERT INTO reserva VALUES (@idReserva,@idUsuario,@idRecurso,@idTipo,@fechaInicio,@fechaFin,@idEstado);",
            'params': result.data
          });
          return {"status": 201, "message": "Se ha creado la reserva"};
        }
        return {'status': 400, 'message': calendar['message']};
      }
      return (bookingsActivo == -1)
          ? {"status": 400, "message": "Error al conectar con la base de datos"}
          : {
              "status": 400,
              "message": "Ya tiene el maximo de reservas activas"
            };
    }
    return {"status": 400, "message": result.errors.toString()};
  }
}
