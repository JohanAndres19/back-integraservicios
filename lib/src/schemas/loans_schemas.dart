import 'package:angel3_validate/angel3_validate.dart';
import 'package:hello_angel/src/schemas/transform_date.dart';

/**
 * Esquema de Prestamos
 */
var _validar = Validator({
  'idEmpleado*': [isString, isNonEmptyString, maxLength(40)],
  'idUsuario*': [isString, isNonEmptyString, maxLength(40)],
  'fechaPrestamo*': [
    isIso8601DateString,
    isNonEmptyString,
    (fechaPrestamo) =>
        dateParse(fechaPrestamo).isBefore(dateNow()) ||
        dateParse(fechaPrestamo) == (dateNow())
  ],
  'idRecurso*': [isString, isNonEmptyString, maxLength(40)],
  'idTipoR*': [isString, isNonEmptyString , (idTipoR) => ['Salon','Laboratorio','Auditorio'].contains(idTipoR)],
});

ValidationResult validateParams(Map<String, dynamic> params) {
  return _validar.check(params);
}
