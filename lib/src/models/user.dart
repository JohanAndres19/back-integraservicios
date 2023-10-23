
import 'package:angel3_framework/angel3_framework.dart';
import 'package:angel3_serialize/angel3_serialize.dart';

part 'user.g.dart';

@serializable
abstract class UserAbstract extends Model{

  String? id;
  String? name;
  String? lastname;
  String? email;
  String? password;

}