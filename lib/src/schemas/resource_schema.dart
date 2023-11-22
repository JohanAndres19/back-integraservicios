import 'package:angel3_validate/angel3_validate.dart';

/**
 * Esquema de Recursos
 */

var _validar = Validator({
  'idRecurso*': [
    isString,
    isNonEmptyString,
    maxLength(40)
  ],
  'idTipoR*': [isString, isNonEmptyString, (idTipoR) => ['Salon','Laboratorio','Auditorio'].contains(idTipoR)],
});

Future<ValidationResult> validateParamsResource(
    Map<String, dynamic> params) async {
  return _validar.check(params);
}
