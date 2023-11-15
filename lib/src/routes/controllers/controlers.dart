import 'package:angel3_framework/angel3_framework.dart';
import 'package:hello_angel/src/routes/controllers/bookings_controller.dart';
import 'package:hello_angel/src/routes/controllers/loans_controller.dart';
import 'package:hello_angel/src/routes/controllers/logincontroller.dart';
import 'package:hello_angel/src/routes/controllers/resources_controller.dart';
import 'package:hello_angel/src/routes/controllers/return_controller.dart';


Future configureServer(Angel app) async {
    await app.configure(Login().configureServer);
    await app.configure(ResourcesController().configureServer);
    await app.configure(BookingController().configureServer);
    await app.configure(LoansController().configureServer);
    await app.configure(ReturnsControllers().configureServer);
}
