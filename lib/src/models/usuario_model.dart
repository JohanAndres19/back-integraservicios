
import 'package:angel3_framework/angel3_framework.dart';
import 'package:angel3_serialize/angel3_serialize.dart';


@serializable
abstract class UserAbstract extends Model{

  
  String? name;
  String? lastname;
  String? email;
  String? password;

}