import 'package:angel3_framework/angel3_framework.dart';
import 'package:postgres/postgres.dart';



@Expose('/login')
class Login extends Controller {

  @Expose('/',method:'POST' )
  Future route1(RequestContext req, ResponseContext res) async {
    
    await req.parseBody();
    
    final conn = req.container?.make<PostgreSQLConnection>();
    await conn?.open();
    final results = await conn?.mappedResultsQuery('SELECT * FROM usuario');

    //final resultado=results?.asMap();
    res.headers['Content-Type'] = 'application/json';
    res.headers['encoding'] = 'utf-8';
    res.json({"data":results});
    await conn?.close();
  }
}
