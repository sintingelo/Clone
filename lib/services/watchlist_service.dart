import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class WatchlistService {
  static const _key = "watchlist";

  static Future<List<String>> getList() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getString(_key);
    if (raw == null) return [];
    return List<String>.from(jsonDecode(raw));
  }

  static Future<void> toggle(String mint) async {
    final p = await SharedPreferences.getInstance();
    final list = await getList();
    if (list.contains(mint)) {
      list.remove(mint);
    } else {
      list.add(mint);
    }
    await p.setString(_key, jsonEncode(list));
  }
}