import 'package:flutter/material.dart';
import 'pages/halaman_detail.dart';
import 'pages/halaman_catatan.dart';
import 'pages/halaman_semua_catatan.dart';

void main() {
  runApp(CoffeeRecipeApp());
}

class CoffeeRecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resep Kopi',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> coffeeList = [
    {"name": "Americano", "image": "assets/images/americano.jpg"},
    {"name": "Cappuccino", "image": "assets/images/cappuccino.jpg"},
    {"name": "Latte", "image": "assets/images/latte.jpg"},
    {"name": "Espresso", "image": "assets/images/espresso.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resep Kopi'),
        actions: [
          IconButton(
            icon: Icon(Icons.note_add ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatatanPage(
                    coffeeName: 'General Coffee Catatan',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Silahkan pilih menu kopi berikut:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: coffeeList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(
                          name: coffeeList[index]['name']!,
                          image: coffeeList[index]['image']!,
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: coffeeList[index]['name']!,
                    child: GridTile(
                      child: Image.asset(coffeeList[index]['image']!, fit: BoxFit.cover),
                      footer: GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Text(coffeeList[index]['name']!),
                        trailing: IconButton(
                          icon: Icon(Icons.note_add, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CatatanPage(
                                  coffeeName: coffeeList[index]['name']!,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllCatatansPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: Text('Lihat Semua Catatan'),
            ),
          ),
        ],
      ),
    );
  }
}
