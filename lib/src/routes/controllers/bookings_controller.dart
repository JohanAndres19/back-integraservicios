import 'package:angel3_framework/angel3_framework.dart';
import 'package:hello_angel/src/models/bookings_model.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';


/**
 * Controlador de  endpoint Reservas
 */
@Expose('/bookings')
class BookingController extends Controller{

  @Expose('/', method: 'GET')
  Future getAllBookings (RequestContext req , ResponseContext res) async{
    var data = await BookingModel.getAllBookings(req.container!.make<PostgresConnection>());
    res.statusCode = data['status'];
    res.json({'message':data['message'],'data':data['data']});
  }

  @Expose('/idresource/:idRecurso', method: 'GET')
  Future getBookingsByResource (RequestContext req , ResponseContext res) async{
    var data = await BookingModel.getBookingsByResource(req.container!.make<PostgresConnection>(),{'idRecurso':req.params['idRecurso'],'idTipo':req.queryParameters['idTipo']});
    res.statusCode = data['status'];
    res.json({'message':data['message'],'data':data['data']});
  }
  
  @Expose('/iduser/:idUsuario',method: 'PUT')
  Future updateBookingByUser (RequestContext req , ResponseContext res) async{
    var data = await BookingModel.getBookingByIdUser(req.container!.make<PostgresConnection>(),{'idUsuario':req.params['idUsuario']});
    res.statusCode = data['status'];
    res.json({'message':data['message']});
  }

  @Expose('/idsatus/:idEstado',method: 'GET')
  Future getBookingById (RequestContext req , ResponseContext res) async{
    var data = await BookingModel.getBookingByStatus(req.container!.make<PostgresConnection>(),{'idReserva':req.params['idEstado']});
    res.statusCode = data['status'];
    res.json({'message':data['message'],'data':data['data']});
  }


  @Expose('/',method: 'POST')
  Future createBooking(RequestContext req , ResponseContext res) async{
      await req.parseBody();
      var data = await BookingModel.createBooking(req.container!.make<PostgresConnection>(),req.bodyAsMap);
      res.statusCode = data['status'];
      res.json({'message':data['message']});   
  }

}