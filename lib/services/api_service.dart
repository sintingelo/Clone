import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';

class ApiService {
  static Future<List<dynamic>> getTrending() async {
    final r = await http.get(Uri.parse("$baseUrl/api/trending"));
    return jsonDecode(r.body)["data"];
  }

  static Future<List<dynamic>> searchToken(String q) async {
    final r = await http.get(Uri.parse("$baseUrl/api/search?q=$q"));
    return jsonDecode(r.body)["data"];
  }

  static Future<dynamic> getTokenInfo(String mint) async {
    final r =
        await http.get(Uri.parse("$baseUrl/api/token-info?mint=$mint"));
    return jsonDecode(r.body)["data"];
  }

  static Future<dynamic> getHolders(String mint) async {
    final r =
        await http.get(Uri.parse("$baseUrl/api/holders?mint=$mint"));
    return jsonDecode(r.body)["data"];
  }
}
