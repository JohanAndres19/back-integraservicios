import 'package:angel3_validate/angel3_validate.dart';

var _validator = Validator({
  'idUsuario*': [
    isString,
    isNonEmptyString,
    maxLength(40),
    (idUsuario) => RegExp(r'^[0-9]+$').hasMatch(idUsuario)
  ],
  'password*': [isString, isNonEmptyString, maxLength(40)],
}, customErrorMessages: {
  'idUsuario': 'Deben solo ser digitos la contraseña'
});

ValidationResult validateParamsUser(Map<String, dynamic> params) {
  return _validator.check(params);
}
