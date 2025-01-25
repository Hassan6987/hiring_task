import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/User.dart';


class AuthRepository {
  Future<User> login() async {
    final response = await http.get(
      Uri.parse('https://my-json-server.typicode.com/hameezk/HiringTask/login'),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }
}
