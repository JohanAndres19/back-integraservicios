
import 'package:angel3_framework/angel3_framework.dart';


/**
 * Controlador de Devoluciones
*/

@Expose('/returns')
class ReturnsControllers extends Controller{

  @Expose('/')
  Future getAllReturns (RequestContext req , ResponseContext res) async{
    res.json({'message':'hola mundo '});
  }

  @Expose('/:id' ,method: 'GET')
  Future getById ( RequestContext req , ResponseContext res) async{
    res.json({'message':'hola mundo '});
  }
   
  @Expose('/',method: 'POST')
  Future registerReturn(RequestContext req , ResponseContext res) async{
      await req.parseBody();
  }

}