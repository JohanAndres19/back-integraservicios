
import 'package:angel3_framework/angel3_framework.dart';
import 'package:hello_angel/src/models/loans_model.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';


/**
 * Controlador de Prestamos
*/

@Expose('/loans')
class LoansController extends Controller{

  @Expose('/')
  Future getAllLoans(RequestContext req , ResponseContext res) async{
      res.json({'message':'Hello this a loans'});
  } 

  @Expose('/id',method: 'GET')
  Future getLoansById(RequestContext req , ResponseContext res) async{
    var data = await LoansModel.getLoansById(req.container!.make<PostgresConnection>(),req.queryParameters);
    res.statusCode = data['status'];
    res.json({'message':data['message'],'data':data['data']});
  
  }


  @Expose('/:id',method: 'POST')
  Future createLoans(RequestContext req , ResponseContext res) async{
      res.json({'message':'Hello this a loans'});
  }

  
  


}

