import 'package:angel3_validate/angel3_validate.dart' ;


/**
 * Esquema de Prestamos
 */
var _validar = Validator({ 
  'idEmpleado*':[isString, isNonEmptyString ,(id)=>id.length<=40],
  'idUsuario*':[isString, isNonEmptyString, (id)=>id.length<=40],
  'fechaPrestamo*':[ isIso8601DateString, isNonEmptyString, (fecha)=>DateTime.parse(fecha).isAfter(DateTime.now())|| DateTime.parse(fecha)==(DateTime.now())], 
  'idRecurso*':[isString, isNonEmptyString ,(id)=>id.length<=40],
  'idTipoRecurso*':[isString, isNonEmptyString],
});


ValidationResult validateParams(Map<String, dynamic> params) {
  return _validar.check(params);  
}

