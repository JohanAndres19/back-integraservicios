import 'package:angel3_container/mirrors.dart';
import 'package:angel3_production/angel3_production.dart';
import 'package:hello_angel/app.dart';
main(List<String> args){
  Runner('Angel3', configureServer, reflector: MirrorsReflector()).run(args);
} 