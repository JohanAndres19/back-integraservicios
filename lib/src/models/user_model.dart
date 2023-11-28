import 'package:hello_angel/src/config/config.dart';
import 'package:hello_angel/src/schemas/user_schema.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class UserModel {

  static Future getUserById(PostgresConnection connection, var params) async {
    var result = await connection.query({
      'query':"SELECT * FROM usuario where lower(idUsuario) = lower(@idUsuario)",
      'params': params
    });
    return (result['error'] != null)?{"status": 400, "message": "Error al conectar con la base de datos", "data": []}:{"status": 200, "message": ""};
  }
  static Future loginUser(PostgresConnection connection, var params) async {
    var result = validateParamsUser(params);
    if (result.errors.isEmpty) {
      var query = await connection.query({
        'query':"SELECT * FROM usuario where lower(idUsuario) = lower(@idUsuario) and lower(contraseña) = lower(@password)",
        'params': result.data
      });
      if (query['error'] != null ) {
        return {"status": 400, "message": "Error al conectar con la base de datos", "data": []};
      }else if (query['data'].length > 0) {
        var token =JWT({'id':result.data['idUsuario']});
        return {"status": 200, "message": "Bienvenido", "data": [{"token":token.sign(getSecretKey() ,expiresIn: Duration(minutes: 30)) }]};
      }
      return {"status": 404, "message": "No se encontro el usuario", "data": []};
    }
    return {"status": 400, "message": result.errors.toString(), "data": []};
  }
}
