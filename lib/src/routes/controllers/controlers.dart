import 'package:angel3_framework/angel3_framework.dart';
import 'package:hello_angel/src/routes/controllers/logincontroller.dart';


Future configureServer(Angel app) async {
    await app.configure(Login().configureServer);
}
