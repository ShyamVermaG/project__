import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/User.dart';


Future<List<User>> fetchUsers() async {

  //the api that we are using
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {

    //taking data
    List<dynamic> jsonData = jsonDecode(response.body);

    return jsonData.map((json) => User.fromJson(json)).toList();

  } else {
    // print("error");
    throw Exception('Failed to load items');
  }
}
