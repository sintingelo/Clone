import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'token_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List list = [];
  final ctrl = TextEditingController();

  Future<void> search(String q) async {
    final r = await ApiService.searchToken(q);
    setState(() => list = r);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: ctrl,
          decoration: const InputDecoration(hintText: "Cari Token"),
          onChanged: search,
        ),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (c, i) {
          final t = list[i];
          return ListTile(
            title: Text(t["baseToken"]["symbol"]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TokenDetailPage(
                    mint: t["baseToken"]["address"],
                    symbol: t["baseToken"]["symbol"],
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