import 'package:angel3_framework/angel3_framework.dart';
import 'package:hello_angel/src/models/user.dart';
import 'package:postgres/postgres.dart';



@Expose('/login')
class Login extends Controller {

  @Expose('/',method:'POST' )
  Future route1(RequestContext req, ResponseContext res) async {
    
    await req.parseBody();
    
    final conn = req.container?.make<PostgreSQLConnection>();

    final results = await conn?.mappedResultsQuery('SELECT * FROM usuario');

    results?.forEach((element) {
      element['usuario']?.addAll({
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });
      print(element['usuario']);
      //var usuario= UserSerializer.fromMap(element['usuario']!);
    });
    //final resultado=results?.asMap();
    res.headers['Content-Type'] = 'application/json';
    res.headers['encoding'] = 'utf-8';
    res.json({"data":results});
    
  }
}
