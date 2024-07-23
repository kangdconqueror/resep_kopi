import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/catatan.dart';

class DetailPage extends StatelessWidget {
  final String name;
  final String image;

  DetailPage({required this.name, required this.image});

  final Map<String, List<String>> recipes = {
    "Americano": [
      "1. Siapkan air panas.",
      "2. Tambahkan 1 shot espresso (7-9 gram).",
      "3. Tuangkan air panas di atasnya.",
    ],
    "Cappuccino": [
      "1. Buat 1 shot espresso (7-9 gram).",
      "2. Panaskan dan busakan susu.",
      "3. Tuangkan susu busa ke dalam espresso.",
      "4. Gunakan perbandingan 1:1:1 (espresso, susu, buih susu).",
    ],
    "Latte": [
      "1. Buat 1 shot espresso (7-9 gram).",
      "2. Panaskan susu.",
      "3. Tuangkan susu panas ke dalam espresso.",
      "4. Gunakan perbandingan 1:3:0.5 (espresso, susu, buih susu).",
    ],
    "Espresso": [
      "1. Giling biji kopi hingga halus (7-9 gram).",
      "2. Tampung di portafilter.",
      "3. Ekstraksi menggunakan mesin espresso.",
    ],
  };

  final Map<String, String> stories = {
    "Americano": "Americano adalah salah satu minuman espresso yang ditambahkan air panas. Jika espresso lebih tebal, untuk Americano rasanya tentu lebih ringan. Jika pada espresso ada krema di bagian atas, namun pada Americano krema sudah hilang karena pada pembuatannya untuk Americano ditambahkan air panas setelah espresso.",
    "Cappuccino": "Cappuccino menjadi salah satu minuman kopi yang disukai masyarakat. Jika dilihat dari komposisi, cappuccino sendiri terbuat dari percampuran susu dan espresso. minuman satu ini cocok bagi anda yang tidak suka kopi dengan rasa yang pekat. Selain susu dan espresso, campuran pada jenis kopi satu ini adalah buih susu. Pada cappuccino, perpaduan antara espresso, susu dan buih susu seimbang.",
    "Latte": "Latte merupakan campuran antara espresso, susu dan buih susu di bagian atasnya. Namun, yang membedakan dengan cappuccino adalah perbandingannya espresso 1, susu 3 dan buih susu ½. Dilihat dari perbandingan ini, latte lebih kuat dengan rasa susunya. Jadi, bagi yang ingin minum kopi dengan rasa kopi yang tidak strong, latte bisa menjadi pilihan yang tepat.",
    "Espresso": "Espresso adalah kopi yang dibuat dengan cara diseduh dengan tekanan dan suhu tinggi, menghasilkan ekstrak kopi yang kental. Kopi espresso dibuat dengan menggiling kopi hingga halus lalu dipadatkan yang biasa disebut dengan “tamping”. Rasa yang kuat dengan teksturnya yang kental membuat kopi satu ini menjadikannya base atau dasar untuk membuat berbagai menu kopi, seperti cappuccino, Americano dan caffe latte.",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: name,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            SizedBox(height: 10),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Cara Membuat:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...recipes[name]!.map((step) => Text(step)).toList(),
            SizedBox(height: 10),
            Text(
              'Cerita Kopi:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(stories[name]!),
            SizedBox(height: 20),
            Text(
              'Catatan:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<Catatan>>(
              future: _loadCatatansForCoffee(name),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final catatans = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: catatans.length,
                  itemBuilder: (context, index) {
                    final catatan = catatans[index];
                    return ListTile(
                      title: Text(catatan.catatan),
                      subtitle: Text('${catatan.catataner} pada ${catatan.timestamp}'),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Catatan>> _loadCatatansForCoffee(String coffeeName) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCatatans = prefs.getStringList('catatans_all') ?? [];
    return savedCatatans
        .map((e) => Catatan.fromJson(jsonDecode(e)))
        .where((catatan) => catatan.coffeeName == coffeeName)
        .toList();
  }
}
