import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class User {
  final String name;
  final bool isOnline;

  User({required this.name, required this.isOnline});
}

class UserProvider with ChangeNotifier {
  List<User> _users = [];

  List<User> get users => _users;

  void fetchUsers() async {
    print("Test 123"); // Debugging statement
    String apiUrl = 'http://localhost:6000/api/users';
    Map<String, String> headers = {};
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token != null) {
      headers['Authorization'] = token;
    }

    final response = await http.get(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    }
    // Simulate fetching data
    _users = [
      User(name: 'Alice', isOnline: true),
      User(name: 'Bob', isOnline: false),
    ];
    notifyListeners(); // Notify listeners
  }
}
