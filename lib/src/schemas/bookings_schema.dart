import 'package:angel3_validate/angel3_validate.dart';
import 'package:hello_angel/src/schemas/transform_date.dart';

/**
 * Esquema de Reservas
 */

var _calendario = Validator({
  'fechaInicio*': [
    isNonEmptyString,
    isIso8601DateString,
     (fechaInicio) {
        return dateVerify(fechaInicio);
    } 
  ],
  'fechaFin*': [
    isNonEmptyString,
    isIso8601DateString,
     (fechaFin) {
        return dateVerify(fechaFin);
    }
  ],
});

bool dateVerify(String date) {
  return dateParse(date).isAfter(dateNow()) || dateParse(date) == dateNow();
}

var _validar = Validator({
  'idUsuario*': [isString, isNonEmptyString, maxLength(40)],
  'idRecurso*': [isString, isNonEmptyString, maxLength(40)],
  'idTipoR*': [
    isString,
    isNonEmptyString,
    (idTipoR) => ['Salon', 'Laboratorio', 'Auditorio'].contains(idTipoR)
  ],
  'idEstado*': [
    isString,
    isNonEmptyString,
    (idEstado) =>
        ['activo', 'cancelado', 'prestado', 'devuelto'].contains(idEstado)
  ],
  'calendarios*': [isList, everyElement(_calendario)],
});

Future<ValidationResult> validateParamsBooking(
    Map<String, dynamic> params) async {
  return _validar.check(params);
}
