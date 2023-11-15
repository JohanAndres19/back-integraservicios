
import 'package:angel3_framework/angel3_framework.dart';
import 'package:hello_angel/src/models/resources_model.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';

/**
 * Controlador de Recursos
*/

@Expose('/resources')
class ResourcesController extends Controller{
  

  @Expose('/')
  Future getAllResources (RequestContext req , ResponseContext res) async{
    var data = await ResourcesModel.getAllResources(req.container!.make<PostgresConnection>());
    res.statusCode = data['status'];
    res.json({'message':data['message'],'data':data['data']});

  }

  @Expose('/:id',method: 'GET')
  Future getResourcesById (RequestContext req , ResponseContext res) async{
    var data = await ResourcesModel.getResourcesById(req.container!.make<PostgresConnection>(),{"idRecurso":req.params['id'],"idTipo":req.queryParameters['idTipo']});
    res.statusCode = data['status'];
    res.json({'message':data['message'],'data':data['data']});
  }
  
  
  @Expose('/', method: 'POST')
  Future createResource(RequestContext req , ResponseContext res) async{
      await req.parseBody();
    
  }


}