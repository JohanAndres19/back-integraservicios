import 'package:angel3_framework/angel3_framework.dart';
import 'package:hello_angel/src/models/resources_model.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';
import 'package:hello_angel/src/services/auth/signin.dart';

/**
 * Controlador de Recursos
*/

@Expose('/resources', middleware: const [verifyToken])
class ResourcesController extends Controller {
  @Expose('/')
  Future getAllResources(RequestContext req, ResponseContext res) async {
    var data = await ResourcesModel.getAllResources(
        req.container!.make<PostgresConnection>());
    res.statusCode = data['status'];
    res.json({'message': data['message'], 'data': data['data']});
  }

  @Expose('/byid', method: 'GET')
  Future getResourcesById(RequestContext req, ResponseContext res) async {
    var data = await ResourcesModel.getResourcesById(
        req.container!.make<PostgresConnection>(), {
      "idRecurso": req.queryParameters['idRecurso'],
      "idTipoR": req.queryParameters['idTipoR']
    });
    res.statusCode = data['status'];
    res.json({'message': data['message'], 'data': data['data']});
  }

  @Expose('/', method: 'POST')
  Future createResource(RequestContext req, ResponseContext res) async {
    await req.parseBody();
  }
}
