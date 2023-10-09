import 'package:angel3_framework/angel3_framework.dart';

Future<bool> deserializeUser(RequestContext req, res) async {
  await req.bodyAsMap;
  var id = req.params['id'] as String;

  return (id == '1') ? true : false;
}

@Expose('/login')
class Login extends Controller {

  @Expose('/',method:'POST' )
  Future route1(RequestContext req, ResponseContext res) async {
    
    print('este es el usuario ${req.bodyAsMap['user']}');
    res.json({"name":"Johan","codigo":"20181020072"});
  }
}
