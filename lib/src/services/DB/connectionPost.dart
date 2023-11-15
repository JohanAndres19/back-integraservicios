import 'dart:convert';

import 'package:postgres/postgres.dart';

class PostgresConnection {
  
  Future<Map<String, dynamic>> query(Map<String, dynamic> query) async {
      final connect = PostgreSQLConnection(
        'ep-cold-recipe-00887370.us-east-1.aws.neon.tech', // dirección del servidor PostgreSQL
        5432, // puerto del servidor PostgreSQL
        'johan-integra', // nombre de la base de datos
        username: 'JohanAndres19', // nombre de usuario
        password: 'rxv2EHS5Tjyk', // contraseña
        useSSL: true,
        encoding: Encoding.getByName('utf8'),
      );
      try {
        await connect.open();
        final data = await connect.mappedResultsQuery(query['query'],substitutionValues: query['params']);
        await connect.close();
        return {"data":data,"error":null};
      } catch (e) {
        print("Ouch fallo la conexion con la base de datos");
        return {"data":null,"error":e.toString()};
      }
  }
  
}
