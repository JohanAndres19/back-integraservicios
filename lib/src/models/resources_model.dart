import 'package:hello_angel/src/services/DB/connectionPost.dart';

class ResourcesModel {

  static Future<dynamic> getAllResources(PostgresConnection connection) async {
    var result = await connection.query({
      'query': "SELECT * FROM recurso;",
      'params': {"": ""}
    });
    return (result['error'] !=null)? {"status":400, "message":"Error al conectar con la base de datos" ,"data":null}: {"status": 200,"message": "", "data": result["data"]};
  }

  static Future<dynamic> getResourcesById(
      PostgresConnection connection, var params) async {
    var result;
    if (params['idTipo'] != null) {
      result = await connection.query({
        'query':
            "SELECT * FROM recurso where lower(idrecurso) = lower(@idRecurso) and lower(idtiporecursopkfk) = lower(@idTipo) ;",
        'params': params
      });
    }else{
       result= await connection.query({
      'query':
          "SELECT * FROM recurso where lower(idrecurso) = lower(@idRecurso) ;",
      'params': params
    });
    }
    return (result['error'] !=null)?{"status":400, "message":"Error al conectar con la base de datos" ,"data":null}: {"status": 200, "message": "","data": result["data"]}; 
  }
}
