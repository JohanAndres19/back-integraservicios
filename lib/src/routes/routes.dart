import 'package:angel3_framework/angel3_framework.dart';
import 'package:file/file.dart';
import 'controllers/controlers.dart' as controllers;

AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    await app.configure(controllers.configureServer);
    app.get('/', (req, res) => res.write("hola mundo"));
    app.fallback((req, res) => throw AngelHttpException.notFound());
  };
}


/** 
 * EndPoint--->"Resources"
 * Recursos 
 * Reservas 
 * Prestamos
 * Devoluciones 
 * Servicios
*/