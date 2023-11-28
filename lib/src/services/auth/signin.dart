
import 'package:angel3_framework/angel3_framework.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:hello_angel/src/config/config.dart';
import 'package:hello_angel/src/models/user_model.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';

Future<bool> verifyToken(RequestContext req , ResponseContext res )async{
  
  var hedertoken = req.headers?['x-access-token']==null? []: req.headers?['x-access-token'];
  if (hedertoken!.isEmpty) {
    res.statusCode = 403;
    res.json({"mesage": "No token provided", "data": []});
    return false;
  }else{
    try {
      var veryfy = JWT.verify(hedertoken[0], getSecretKey());
      var exp = veryfy.payload['id'];
      var result = await UserModel.getUserById(req.container!.make<PostgresConnection>(), {'idUsuario': exp});
      res.statusCode = result['status'];
      return result['status'] == 200 ? true : false;
    } on  JWTExpiredException {
      res.json({"mesage": "Token expired", "data": []});
      return false;
    }
  }
}