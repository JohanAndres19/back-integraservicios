import 'package:angel3_framework/angel3_framework.dart';
import 'package:hello_angel/src/models/user_model.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';


@Expose('/user')
class UserController extends Controller {


  @Expose('/signin',method: 'POST' )
  Future singInUser(RequestContext req , ResponseContext res) async{
    await req.parseBody();
    var data = await UserModel.loginUser(req.container!.make<PostgresConnection>(),req.bodyAsMap);
    res.statusCode = data['status'];
    res.json({'message':data['message'] ,'data': data['data']});
  }

}