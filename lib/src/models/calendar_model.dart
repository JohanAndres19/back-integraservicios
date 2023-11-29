import 'package:hello_angel/src/schemas/resource_schema.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';
import 'package:uuid/uuid.dart';

class CalendarModel {
  static Future getCalendarByResource(
      PostgresConnection connection, var params) async {
    var result = await validateParamsResource(params);
    if (result.errors.isEmpty) {
      var resultquery = await connection.query({
        'query':
            "SELECT * FROM calendario where lower(idrecursopkfk) = lower(@idRecurso) and lower(idtiporecursopkfk) = lower(@idTipo)",
        'params': result.data
      });
      return (resultquery['error'] != null)
          ? {
              "status": 400,
              "message":
                  "Error al conectar con la base de datos ${resultquery['error']}",
              "data": null
            }
          : {"status": 200, "data": resultquery["data"], "message": ""};
    }
    return {"status": 400, "message": result.errors.toString(), "data": null};
  }

  static Future getCalendarByBookings(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "SELECT to_char(fechaInicio,'YYYY-MM-DD HH24:MI:SS') as Fi, to_char(fechaFinal,'YYYY-MM-DD HH24:MI:SS') as Ff FROM calendario ca where lower(ca.idreservapkfk) = lower(@idReserva)",
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

  static Future getCalendarResourceByDate(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "SELECT * FROM calendario c, reserva r where lower(c.idrecursopkfk) = lower(@idRecurso) and lower(c.idtiporecursopkfk) = lower(@idTipoR) and fechainicio= @fechaI and fechafinal = @fechaF and lower(r.idreserva) = lower(@idReserva) and lower(r.idestado)='activo';",
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

  static Future createCalendar(
      PostgresConnection connection, var params) async {
    for (var i in params['calendarios']) {
      var resultCruce =
          await CalendarModel.getCalendarResourceByDate(connection, {
        'idRecurso': params['idRecurso'],
        'idTipoR': params['idTipoR'],
        'fechaI': i['fechaInicio'],
        'fechaF': i['fechaFin'],
        'idReserva': params['idReserva'],
      });
      if (resultCruce['status'] != 400 && resultCruce['data'].length == 0) {
        await connection.query({
          'query':
              "INSERT INTO calendario VALUES (@idCalendario,@fechaI,@fechaF,@idReserva, @idUsuario, @idRecurso, @idTipoR)",
          'params': {
            'idCalendario': Uuid().v1(),
            'idReserva': params['idReserva'],
            'idUsuario': params['idUsuario'],
            'idRecurso': params['idRecurso'],
            'idTipoR': params['idTipoR'],
            'fechaI': i['fechaInicio'],
            'fechaF': i['fechaFin'],
          }
        });
      } else {
        return (resultCruce['status'] == 400)
            ? {
                "status": 400,
                "message": "Error al conectar con la base de datos",
                "data": []
              }
            : {
                "status": 400,
                "message": "Presenta cruce en la fecha seleccionada ",
                "data": []
              };
      }
    }
    return {"status": 201, "message": "Se ha creado el calendario", "data": []};
  }

  static Future deleteCalendarByBookings(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "Delete from calendario where lower(idreservapkfk) = lower(@idReserva)",
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
            "message": "Se ha eliminado el calendario",
            "data": []
          };
  }

  static Future deleteCalendarById(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "Delete from calendario where lower(idcalendario) = lower(@idCalendario)",
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
            "message": "Se ha eliminado el calendario",
            "data": []
          };
  }
}
