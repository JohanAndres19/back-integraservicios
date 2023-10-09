import 'package:angel3_framework/angel3_framework.dart';
import 'package:file/file.dart';
import 'controllers/controlers.dart' as controllers;

AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {

    await app.configure(controllers.configureServer);
    /* app.get('/int:number', (req, res) async {
      //await req.parseBody();
 
      res.json({
        "name": [1, 2, 3, 4, 5, req.params["number"]],
        "prueba": "johanannan"
      });
    });
 */
    app.fallback((req, res) => throw AngelHttpException.notFound());
  };
}
