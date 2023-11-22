import 'package:hello_angel/src/schemas/resource_schema.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';

class ResourcesModel {
  static Future<dynamic> getAllResources(PostgresConnection connection) async {
    var result = await connection.query({
      'query': "SELECT * FROM recurso;",
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

  static Future<dynamic> getResourcesById(
      PostgresConnection connection, var params) async {
    var result = await validateParamsResource(params);
    if (result.errors.isEmpty) {
      var resultquery = await connection.query({
        'query':
            "SELECT * FROM recurso where lower(idrecurso) = lower(@idRecurso) and lower(idtiporecursopkfk) = lower(@idTipoR) ;",
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
    return {"status": 400, "message": result.errors.toString(), "data": null};
  }
}
