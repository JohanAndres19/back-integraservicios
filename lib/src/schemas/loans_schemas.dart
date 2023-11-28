import 'package:angel3_validate/angel3_validate.dart';
import 'package:hello_angel/src/schemas/transform_date.dart';

/**
 * Esquema de Prestamos
 */

ValidationResult validateParamsLoans(Map<String, dynamic> params) {
  var _validar = Validator({
    'idEmpleado*': [
      isString,
      isNonEmptyString,
      maxLength(40),
      (idEmpleado) => RegExp(r'^[0-9]+$').hasMatch(idEmpleado)
    ],
    'idUsuario*': [
      isString,
      isNonEmptyString,
      maxLength(40),
      (idUsuario) => RegExp(r'^[0-9]+$').hasMatch(idUsuario)
    ],
    'fechaPrestamo*': [
      isIso8601DateString,
      isNonEmptyString,
      (fechaPrestamo) =>
          dateParse(fechaPrestamo).isBefore(dateStart(params['fechaInicio'])) ||
          dateParse(fechaPrestamo) == (dateStart(params['fechaInicio']))
    ],
    'idRecurso*': [isString, isNonEmptyString, maxLength(40)],
    'idTipoR*': [
      isString,
      isNonEmptyString,
      (idTipoR) => ['Salon', 'Laboratorio', 'Auditorio'].contains(idTipoR)
    ],
    'idReserva*': [isString, isNonEmptyString, maxLength(40)],
    'idEstado*': [
      isString,
      isNonEmptyString,
      (idEstado) =>
          ['activo', 'cancelado', 'prestado', 'devuelto'].contains(idEstado)
    ],
  });
  return _validar.check(params);
}
