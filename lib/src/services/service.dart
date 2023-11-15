
import 'package:angel3_framework/angel3_framework.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';

Future configureServer(Angel app) async {
  try {
    final connection = PostgresConnection();    
    app.container.registerSingleton<PostgresConnection>(connection); 
  } catch (e) {
    print(e.toString());
  }
}


