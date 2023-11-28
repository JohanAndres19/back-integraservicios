import 'package:angel3_framework/angel3_framework.dart';
import 'package:hello_angel/src/models/bookings_model.dart';
import 'package:hello_angel/src/models/calendar_model.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';
import 'package:hello_angel/src/services/auth/signin.dart';

/**
 * Controlador de  endpoint Reservas
 */
@Expose('/bookings',middleware: const[verifyToken])
class BookingController extends Controller {
  // metodos get de las reservas
  @Expose('/', method: 'GET')
  Future getAllBookings(RequestContext req, ResponseContext res) async {
    var data = await BookingModel.getAllBookings(
        req.container!.make<PostgresConnection>());
    res.statusCode = data['status'];
    res.json({'message': data['message'], 'data': data['data']});
  }

  @Expose('/idresource', method: 'GET')
  Future getBookingsByResource(RequestContext req, ResponseContext res) async {
    var data = await BookingModel.getBookingsByResource(
        req.container!.make<PostgresConnection>(), req.queryParameters);
    res.statusCode = data['status'];
    res.json({'message': data['message'], 'data': data['data']});
  }

  @Expose('/iduser/:idUsuario', method: 'GET')
  Future getBookingsByUser(RequestContext req, ResponseContext res) async {
    var data = await BookingModel.getBookingByIdUser(
        req.container!.make<PostgresConnection>(),
        {'idUsuario': req.params['idUsuario']});
    res.statusCode = data['status'];
    res.json({'message': data['message'], 'data': data['data']});
  }

  @Expose('/idsatus/:idEstado', method: 'GET')
  Future getBookingByStatus(RequestContext req, ResponseContext res) async {
    var data = await BookingModel.getBookingByStatus(
        req.container!.make<PostgresConnection>(),
        {'idReserva': req.params['idEstado']});
    res.statusCode = data['status'];
    res.json({'message': data['message'], 'data': data['data']});
  }
  @Expose('/userstate', method: 'GET')
  Future getBookingsByUserAndState(RequestContext req , ResponseContext res) async{
    var data = await BookingModel.getBookingByUserAndStatus(
      req.container!.make<PostgresConnection>(),req.queryParameters
    );
    res.statusCode = data['status'];
    res.json({'message':data['message'],'data':data['data']});
  }

  @Expose('/calendar/:idReserva', method: 'GET')
  Future getCalendarByBookings(RequestContext req, ResponseContext res) async {
    var data = await CalendarModel.getCalendarByBookings(
        req.container!.make<PostgresConnection>(), req.params);
    res.statusCode = data['status'];
    res.json({'message': data['message'], 'data': data['data']});
  }


  @Expose('/calendarbyresource', method: 'GET')
  Future getCalendarByResource(RequestContext req, ResponseContext res) async {
    var data = await CalendarModel.getCalendarByResource(
        req.container!.make<PostgresConnection>(), {
      'idRecurso': req.queryParameters['idRecurso'],
      'idTipo': req.queryParameters['idTipoR']
    });
    res.statusCode = data['status'];
    res.json({'message': data['message'], 'data': data['data']});
  }

  // metodos post de las reservas
  @Expose('/', method: 'POST')
  Future createBooking(RequestContext req, ResponseContext res) async {
    await req.parseBody();
    var data = await BookingModel.createBooking(
        req.container!.make<PostgresConnection>(), req.bodyAsMap);
    res.statusCode = data['status'];
    res.json({'message': data['message'] , 'data': data['data']});
  }

  // metodos patch de las reservas
  @Expose('/updatestate', method: 'PATCH')
  Future updateStateBooking(RequestContext req, ResponseContext res) async {
    await req.parseBody();
    var data = await BookingModel.updateStateBooking(
        req.container!.make<PostgresConnection>(), req.bodyAsMap);
    res.statusCode = data['status'];
    res.json({'message': data['message'], 'data': data['data']}); 
  }
}
