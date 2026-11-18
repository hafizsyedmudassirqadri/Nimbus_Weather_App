import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiController {
  Future<void> saveToken({required String token}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String> retrieveToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString('token') ?? "";
  }

  Future<(int, String)> post({
    required String url,
    required Map<String, String> body,
    bool isToken = false,
  }) async {
    var myHeader = {"Content-Type": "application/json"};

    if (isToken) {
      String token = await retrieveToken();
      myHeader.addAll({'Authorization': 'Bearer $token'});
    }

    var myBody = jsonEncode(body);
    Uri uri = Uri.parse(url);

    try {
      var response = await http.post(uri, headers: myHeader, body: myBody);
      return (response.statusCode, response.body);
    } catch (e, stackTrace) {
      print("EXEPTION $e");
      print("STACKTRACE $stackTrace");
      return (600, "Something went wrong");
    }
  }

  Future<(int, String)> get({
    required String url,

    bool isToken = false,
     
    Map<String, String>? queryParams,
  }) async {
    Map<String, String> myHeader = {};

    if (isToken) {
      String token = await retrieveToken();
      myHeader.addAll({'Authorization': 'Bearer $token'});
    }

    Uri uri = Uri.parse(url);
    if (queryParams != null) {
      uri = uri.replace(queryParameters: queryParams);
    }

    print("===========> URI IN GET API==========> $uri");

    try {
      var response = await http.get(uri, headers: myHeader);
      return (response.statusCode, response.body);
    } catch (e, stackTrace) {
      print("EXEPTION $e");
      print("STACKTRACE $stackTrace");
      return (600, "Something went wrong");
    }
  }
}
