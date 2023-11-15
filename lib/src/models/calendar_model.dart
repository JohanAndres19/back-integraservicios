import 'package:hello_angel/src/schemas/calendar_schema.dart';
import 'package:hello_angel/src/services/DB/connectionPost.dart';
import 'package:uuid/uuid.dart';

class CalendarModel {
  
  static Future getCalendarResourceByDate(PostgresConnection connection ,var params ) async{
    var result= await connection.query({
      'query':"SELECT * FROM calendario where lower(idrecursopkfk) = lower(@idRecurso) and lower(idtiporecursopkfk) = lower(@idTipo) and fechainicio= @fechaI and fechafinal = @fechaF;" ,
      'params': params
    });
    return (result['error'] !=null)?{"status":400, "message":"Error al conectar con la base de datos"}: {"status": 200, "data": result["data"]};
  }


  static Future createCalendar(PostgresConnection connection, var params) async{
      var result = await validateParamsCalendar(params);
      if (result.errors.isEmpty) {
        var resultCrossing =
            await CalendarModel.getCalendarResourceByDate(connection, { // buscar el calendario del recurso
          'idRecurso': result.data['idRecurso'],
          'idTipo': result.data['idTipoR'],
          'fechaI': result.data['fechaInicio'],
          'fechaF': result.data['fechaFin'],
        });
        if (resultCrossing.isEmpty) { // si no hay cruse se crea
          result.data.addAll({'idCalendario': Uuid().v1()});
          await connection.query({
            'query': "INSERT INTO calendario VALUES (@idCalendario,@fechaI, @fechaF,@idReserva,@idUsuario,@idRecurso,@idTipo );",
            'params': result.data
          });
          return {"status": 201 , "message": "Se ha creado el calendario"};
        }
        return {"status": 400 , "message": "Presenta cruce de fechas con este recurso"};
      }
      return {"status": 400 , "message": result.errors.toString()};
  }

  


}