import 'package:angel3_framework/angel3_framework.dart';



@Expose('/login')
class Login extends Controller {

  @Expose('/',method:'POST' )
  Future route1(RequestContext req, ResponseContext res) async {
    
    await req.parseBody();
    
    print(req.bodyAsMap['user']);

    res.json({"name":"Johan","codigo":"20181020072"});
  }
}
