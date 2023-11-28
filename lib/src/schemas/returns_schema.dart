import 'package:angel3_validate/angel3_validate.dart';
import 'package:hello_angel/src/schemas/transform_date.dart';

/*
* Esquema de Devoluciones
*/

ValidationResult validateParamsReturns(Map<String, dynamic> params) {
  var _validar = Validator({
    'idEmpleado*': [isString, isNonEmptyString, maxLength(40)],
    'idUsuario*': [isString, isNonEmptyString, maxLength(40)],
    'calificacion*': [isInt, greaterThanOrEqualTo(0.0), lessThanOrEqualTo(5.0)],
    'fechaDevolucion*': [
      isIso8601DateString,
      isNonEmptyString,
      (fechaDevolucion) =>
          dateParse(fechaDevolucion).isAfter(dateEnd(params['fechaFin'])) ||
          dateParse(fechaDevolucion) == (dateEnd(params['fechaFin']))
    ],
    'idRecurso*': [isString, isNonEmptyString, maxLength(40)],
    'idTipoR*': [isString, isNonEmptyString],
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
