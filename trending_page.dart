import 'dart:async';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'search_page.dart';
import 'token_detail_page.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});
  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  List tokens = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    load();
    timer = Timer.periodic(const Duration(seconds: 2), (_) => load());
  }

  Future<void> load() async {
    final data = await ApiService.getTrending();
    setState(() => tokens = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GMGN Trending"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tokens.length,
        itemBuilder: (c, i) {
          final t = tokens[i];
          return ListTile(
            title: Text(t["symbol"] ?? "-"),
            subtitle: Text("Vol \$${t["volume"]}"),
            trailing: Text(
              "${t["change"] ?? 0}%",
              style: TextStyle(
                color:
                    (t["change"] ?? 0) > 0 ? Colors.green : Colors.red,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TokenDetailPage(
                    mint: t["mint"],
                    symbol: t["symbol"],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}