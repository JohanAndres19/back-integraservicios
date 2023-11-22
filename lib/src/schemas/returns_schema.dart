import 'package:angel3_validate/angel3_validate.dart';
import 'package:hello_angel/src/schemas/transform_date.dart';

/*
* Esquema de Devoluciones
*/
var _validar = Validator({
  'idEmpleado*': [isString, isNonEmptyString, maxLength(40)],
  'idUsuario*': [isString, isNonEmptyString, maxLength(40)],
  'calificacion*': [isInt, greaterThanOrEqualTo(0.0), lessThanOrEqualTo(5.0)],
  'fechaDevolucion*': [
    isIso8601DateString,
    isNonEmptyString,
    (fechaDevolucion) =>
        dateParse(fechaDevolucion).isAfter(dateNow()) ||
        dateParse(fechaDevolucion) == (dateNow())
  ],
  'idRecurso*': [isString, isNonEmptyString, maxLength(40)],
  'idTipoR*': [isString, isNonEmptyString],
});

ValidationResult validateParams(Map<String, dynamic> params) {
  return _validar.check(params);
}
