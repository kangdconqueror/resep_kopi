import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/catatan.dart';

class AllCatatansPage extends StatefulWidget {
  @override
  _AllCatatansPageState createState() => _AllCatatansPageState();
}

class _AllCatatansPageState extends State<AllCatatansPage> {
  final List<Catatan> _allCatatans = [];

  @override
  void initState() {
    super.initState();
    _loadAllCatatans();
  }

  Future<void> _loadAllCatatans() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    final catatans = <Catatan>[];

    for (var key in keys) {
      if (key == 'catatans_all') {
        final savedCatatans = prefs.getStringList(key) ?? [];
        catatans.addAll(savedCatatans.map((e) => Catatan.fromJson(jsonDecode(e))).toList());
      }
    }

    setState(() {
      _allCatatans.addAll(catatans);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semua Catatan'),
      ),
      body: Padding(
		  padding: const EdgeInsets.all(16.0),
		  child: ListView.builder(
			itemCount: _allCatatans.length,
			itemBuilder: (context, index) {
			  final catatan = _allCatatans[index];
			  return ListTile(
				title: Text('"${catatan.catatan}"'),
				subtitle: Column(
				  crossAxisAlignment: CrossAxisAlignment.start,
				  children: [
					Text('Resep: ${catatan.coffeeName}'),
					Text('${catatan.catataner} pada ${catatan.timestamp}'),
				  ],
				),
			  );
			},
		  ),
      ),
    );
  }
}
