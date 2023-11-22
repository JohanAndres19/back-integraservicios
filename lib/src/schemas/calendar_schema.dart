import 'package:angel3_validate/angel3_validate.dart';

/**
 * Esquema de Calendario
 */

var _validar = Validator({
  'idReserva*': [isString, isNonEmptyString, maxLength(40)],
  'idUsuario*': [isString, isNonEmptyString, maxLength(40)],
  'idRecurso*': [isString, isNonEmptyString, maxLength(40)],
  'idTipoR*': [isString, isNonEmptyString, (idTipoR) => ['Salon','Laboratorio','Auditorio'].contains(idTipoR)],
  'fechaInicio*': [
    isIso8601DateString,
    isNonEmptyString,
  ],
  'fechaFin*': [
    isIso8601DateString,
    isNonEmptyString,
  ],
});



Future<ValidationResult> validateParamsCalendar(
    Map<String, dynamic> params) async {
  return _validar.check(params);
}