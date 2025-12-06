import 'package:flutter/material.dart';
import '../services/api_service.dart';

class TokenDetailPage extends StatefulWidget {
  final String mint;
  final String symbol;

  const TokenDetailPage({
    super.key,
    required this.mint,
    required this.symbol,
  });

  @override
  State<TokenDetailPage> createState() => _TokenDetailPageState();
}

class _TokenDetailPageState extends State<TokenDetailPage> {
  dynamic data;
  dynamic holders;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    final d = await ApiService.getTokenInfo(widget.mint);
    final h = await ApiService.getHolders(widget.mint);
    setState(() {
      data = d;
      holders = h;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null || holders == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.symbol)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Text("Price: ${data["priceUsd"]}"),
          Text("Liquidity: ${data["liquidity"]?["usd"]}"),
          Text("Volume: ${data["volume"]?["h24"]}"),
          const SizedBox(height: 12),
          Text(
            "Pemegang(${holders["holders"]}) ${holders["activeHolderPct"]}%",
          ),
        ]),
      ),
    );
  }
}