import 'package:angel3_validate/angel3_validate.dart';


/*
* Esquema de Devoluciones
*/
var _validar = Validator({ 
  'idEmpleado*':[isString, isNonEmptyString ,(id)=>id.length<=40],
  'idUsuario*':[isString, isNonEmptyString, (id)=>id.length<=40],
  'calificacion*':[isInt, greaterThanOrEqualTo(0.0), lessThanOrEqualTo(5.0)],
  'fechaDevolucion*':[ isIso8601DateString, isNonEmptyString, (fecha)=>DateTime.parse(fecha).isAfter(DateTime.now())|| DateTime.parse(fecha)==(DateTime.now())], 
  'idRecurso*':[isString, isNonEmptyString ,(id)=>id.length<=40],
  'TipoRecurso*':[isString, isNonEmptyString],
});


ValidationResult validateParams(Map<String, dynamic> params) {
  return _validar.check(params);  
}
