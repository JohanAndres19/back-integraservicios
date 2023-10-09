import 'dart:async';
import 'package:angel3_framework/angel3_framework.dart';
import 'package:file/local.dart';
import 'src/routes/routes.dart' as routes;

Future configureServer( Angel app) async{
  var fs = const LocalFileSystem();
  //await app.configure(configuration.configureServer(fs));
  await app.configure(routes.configureServer(fs));
}