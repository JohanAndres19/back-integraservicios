import 'dart:convert';

import 'package:angel3_framework/angel3_framework.dart';
import 'package:postgres/postgres.dart';

Future configureServer(Angel app) async {
  try {
    final connection = PostgreSQLConnection(
      'ep-cold-recipe-00887370.us-east-1.aws.neon.tech', // dirección del servidor PostgreSQL
      5432, // puerto del servidor PostgreSQL
      'neondb', // nombre de la base de datos
      username: 'JohanAndres19', // nombre de usuario
      password: 'rxv2EHS5Tjyk', // contraseña
      useSSL: true,
      encoding: Encoding.getByName('utf8'),
    );
    await connection.open();
    app.container.registerSingleton<PostgreSQLConnection>(connection); 
  } catch (e) {
    print("error en conexión a la base de datos");
    print(e.toString());
  }
}


