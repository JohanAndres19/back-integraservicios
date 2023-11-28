
import 'package:angel3_framework/angel3_framework.dart';
import 'package:hello_angel/src/models/loans_model.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';
import 'package:hello_angel/src/services/auth/signin.dart';


/**
 * Controlador de Prestamos
*/

@Expose('/loans' ,middleware: const[verifyToken])
class LoansController extends Controller{

  @Expose('/')
  Future getAllLoans(RequestContext req , ResponseContext res) async{
    var data = await LoansModel.getAllLoans(req.container!.make<PostgresConnection>());
    res.statusCode = data['status'];
    res.json({'message':data['message'],'data':data['data']});
  } 

  @Expose('/byloans/:idPrestamo',method: 'GET')
  Future getLoansById(RequestContext req , ResponseContext res) async{
    var data = await LoansModel.getLoansById(req.container!.make<PostgresConnection>(),req.params);
    res.statusCode = data['status'];
    res.json({'message':data['message'],'data':data['data']});
  
  }

  @Expose('/byuser/:idUsuario')
  Future getLoansByUser(RequestContext req , ResponseContext res) async{
    var data = await LoansModel.getLoansByUser(req.container!.make<PostgresConnection>(),req.params);
    res.statusCode = data['status'];
    res.json({'message':data['message'],'data':data['data']});
  }
  
  @Expose('/byemployee/:idEmpleado')
  Future getLoansByEmployee(RequestContext req , ResponseContext res) async{
    var data = await LoansModel.getLoansByEmployee(req.container!.make<PostgresConnection>(),req.params);
    res.statusCode = data['status'];
    res.json({'message':data['message'],'data':data['data']});
  }
  
  @Expose('/resourcesOfLoans')
  Future getResourcesOfLoans(RequestContext req , ResponseContext res) async{
    var data = await LoansResourceModel.getLoansResourceByResource(req.container!.make<PostgresConnection>(),req.queryParameters);
    res.statusCode = data['status'];
    res.json({'message':data['message'],'data':data['data']});
  }

  @Expose('/',method: 'POST')
  Future createLoans(RequestContext req , ResponseContext res) async{
      await req.parseBody();
      var data = await LoansModel.createLoans(req.container!.make<PostgresConnection>(),req.bodyAsMap);
      res.statusCode = data['status'];
      res.json({'message':data['message'],'data':data['data']});
  }


}

