import 'dart:convert';

class ApiConstants {
  static const _baseUrl = "https://nimbus-api-vtoz.onrender.com/api/v1";

  static const loginApi = "$_baseUrl/auth/login";
  static const registerApi = "$_baseUrl/auth/register";
  static const rememberMe = "$_baseUrl/auth/me";
  static const regionApi = "$_baseUrl/cities/regions";
  static const String cityApi = '$_baseUrl/cities';

  // static cityApi(int page) {
  //   return "$_baseUrl/cities?page=$page&limit=8";
  // }
}
