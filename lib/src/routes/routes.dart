import 'package:angel3_cors/angel3_cors.dart';
import 'package:angel3_framework/angel3_framework.dart';
import 'package:file/file.dart';
import 'controllers/controlers.dart' as controllers;

AngelConfigurer configureServer(FileSystem fileSystem) {
  return (Angel app) async {
    app.fallback(cors());
    await app.configure(controllers.configureServer);
    app.get('/', (req, res) => res.write("hola mundo"));
    app.fallback((req, res) => throw AngelHttpException.notFound());
  };
}


/** 
 * EndPoint -->"Resources"
 * Recursos --> resources *
 * Reservas --> bookings  *
 * Prestamos --> loans *
 * Devoluciones  --> returns *
 * Servicios ?
*/