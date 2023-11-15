import 'package:angel3_validate/angel3_validate.dart' ;


/**
 * Esquema de Calendario
 */

var _validar = Validator({ 
  'idReserva*':[isString, isNonEmptyString, (id)=>id.length<=40],
  'idUsuario*':[isString, isNonEmptyString, (id)=>id.length<=40],
  'idRecurso*':[isString, isNonEmptyString ,(id)=>id.length<=40],
  'idTipoR*':[isString, isNonEmptyString],
  'fechaInicio*':[ isIso8601DateString, isNonEmptyString, (fecha)=>DateTime.parse(fecha).isAfter(DateTime.now())|| DateTime.parse(fecha)==(DateTime.now())], 
  'fechaFin*':[ isIso8601DateString, isNonEmptyString , (fecha)=>DateTime.parse(fecha).isAfter(DateTime.now())|| DateTime.parse(fecha)==(DateTime.now())],
});


Future<ValidationResult> validateParamsCalendar(Map<String, dynamic> params) async  {
  return _validar.check(params);  
}
