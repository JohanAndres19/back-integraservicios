import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;


DateTime dateParse(String date){
  tz.initializeTimeZones();
  var locationBogota = tz.getLocation('America/Bogota');
  var nowBogota = tz.TZDateTime.from(DateTime.parse(date), locationBogota);
  return nowBogota;
}

DateTime dateNow() {
  tz.initializeTimeZones();
  var locationBogota = tz.getLocation('America/Bogota');
  var nowBogota = tz.TZDateTime.from(DateTime.now(), locationBogota);
  return nowBogota;
}

DateTime dateStart(String date) {
  tz.initializeTimeZones();
  return dateParse(date);
}

DateTime dateEnd(String date) {
  tz.initializeTimeZones();
  return dateParse(date);
}