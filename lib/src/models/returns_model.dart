
import 'package:hello_angel/src/models/bookings_model.dart';
import 'package:hello_angel/src/schemas/resource_schema.dart';
import 'package:hello_angel/src/schemas/returns_schema.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';
import 'package:uuid/uuid.dart';

class ReturnsModel {
  static Future getAllLoans(PostgresConnection connection) async {
    var result = await connection.query({
      'query': "SELECT * FROM devolucion;",
    });
    return (result['error'] != null)
        ? {"status": 400, "message": "Error al conectar con la base de datos", "data": []}
        : {"status": 200, "message": "", "data": result["data"]};
  }

  static Future getLoansById(PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "SELECT * FROM devolucion where lower(iddevolucion) = lower(@iddevolucion)",
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

  static Future getLoansByUser(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "SELECT * FROM devolucion where lower(idusuariopkfk) = lower(@idUsuario)",
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

  static Future getLoansByEmployee(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "SELECT * FROM devolucion where lower(idempleadopkfk) = lower(@idEmpleado)",
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

  static Future createLoans(PostgresConnection connection, var params) async {
    var result = validateParamsReturns(params);
    if (result.errors.isEmpty) {
      var devolucion = {'iddevolucion': Uuid().v1(), ...result.data};
      var resultquery = await connection.query({
        'query':
            "Insert into devolucion values (@iddevolucion,@idEmpleado,@idUsuario,@fechadevolucion)",
        'params': devolucion
      });
      var resultCreateResource = (resultquery['error'] == null)
          ? await ReturnsResourceModel.createLoansResource(connection, devolucion)
          : {
              "status": 400,
              "message": "Error al crear el devolucion del recurso",
              "data": []
            };
      if (resultCreateResource['status'] == 201) {
        await BookingModel.updateStateBooking(connection,
            {'idResrva': params['idReserva'], 'idEstado': params['idEstado']});
        return {
          "status": 201,
          "message": "Se ha creado el devolucion",
          "data": []
        };
      } else {
        await ReturnsModel.deleteLoansById(connection, devolucion);
        return resultCreateResource;
      }
    }
    return {"status": 400, "message": result.errors.toString(), "data": []};
  }

  static Future deleteLoansById(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "DELETE FROM devolucion where lower(iddevolucion) = lower(@iddevolucion)",
      'params': params
    });
    return (result['error'] != null)
        ? {
            "status": 400,
            "message": "Error al conectar con la base de datos",
            "data": []
          }
        : {"status": 200, "message": "Se ha eliminado el devolucion", "data": []};
  }
}

/*
 clase que representa la 
 el la funcinalidad  de  la tabla devolociones recurso
*/
class ReturnsResourceModel {
  static Future getLoansResourceByIdLoans(
      PostgresConnection connection, Map<String, dynamic> params) async {
    var result = await connection.query({
      'query':
          "SELECT * FROM devolucionrecurso where lower(iddevolucionpkfk) = lower(@iddevolucion)",
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

  static Future getLoansResourceByUser(
      PostgresConnection connection, Map<String, dynamic> params) async {
    var result = await connection.query({
      'query':
          "SELECT * FROM devolucionrecurso where lower(idusuariopkfk) = lower(@idUsuario)",
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

  static Future getLoansResourceByEmployee(
      PostgresConnection connection, Map<String, dynamic> params) async {
    var result = await connection.query({
      'query':
          "SELECT * FROM devolucionrecurso where lower(idempleadopkfk) = lower(@idempleado)",
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

  static Future getLoansResourceByResource(
      PostgresConnection connection, var params) async {
    var result = await validateParamsResource(params);
    if (result.errors.isEmpty) {
      var resultquery = await connection.query({
        'query':
            "SELECT * FROM devolucionrecurso where lower(idrecursopkfk) = lower(@idRecurso) and lower(idtiporecursopkfk) = lower(@idTipoR) ;",
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

  static Future createLoansResource(
      PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':
          "Insert into devolucionrecurso values (@iddevolucion,@idEmpleado,@idUsuario,@idRecurso,@idTipoR)",
      'params': params
    });
    return (result['error'] != null)
        ? {"status": 400, "message": "Error al conectar con la base de datos"}
        : {
            "status": 201,
            "message": "Se ha creado el devolucion del recurso",
            "data": []
          };
  }
}