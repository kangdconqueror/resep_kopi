import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/catatan.dart';

class CatatanPage extends StatefulWidget {
  final String? coffeeName;

  CatatanPage({this.coffeeName});

  @override
  _CatatanPageState createState() => _CatatanPageState();
}

class _CatatanPageState extends State<CatatanPage> {
  final _catatanController = TextEditingController();
  final _nameController = TextEditingController();

  void _submitCatatan() async {
    final name = _nameController.text;
    final catatan = _catatanController.text;
    final timestamp = DateTime.now().toString();
    final coffeeName = widget.coffeeName ?? 'General';

    if (name.isEmpty || catatan.isEmpty) return;

    final catatanData = Catatan(
      catataner: name,
      catatan: catatan,
      timestamp: timestamp,
      coffeeName: coffeeName,  // Tambahkan coffeeName
    );

    final prefs = await SharedPreferences.getInstance();
    final key = 'catatans_all';
    final savedCatatans = prefs.getStringList(key) ?? [];
    savedCatatans.add(jsonEncode(catatanData.toJson()));
    await prefs.setStringList(key, savedCatatans);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Catatan berhasil ditambahkan!')),
    );

    _catatanController.clear();
    _nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coffeeName != null ? 'Catatan ${widget.coffeeName}' : 'Tulis Catatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.coffeeName != null)
              Text(
                'Catatan untuk ${widget.coffeeName}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _catatanController,
              decoration: InputDecoration(
                labelText: 'Catatan',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitCatatan,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown, // Warna latar belakang
                foregroundColor: Colors.white, // Warna teks
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0), // Membuat sudut tombol melengkung
                ),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Text('Kirim Catatan'),
            ),
          ],
        ),
      ),
    );
  }
}
