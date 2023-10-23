import 'dart:async';
import 'package:angel3_framework/angel3_framework.dart';
import 'package:file/local.dart';
import 'src/routes/routes.dart' as routes;
import 'src/service.dart' as service; 


Future configureServer( Angel app) async{
  var fs = const LocalFileSystem();
  await app.configure(routes.configureServer(fs));
  await app.configure(service.configureServer);
}