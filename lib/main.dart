import 'package:flutter/material.dart';
import 'detail_page.dart';

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

class HomePage extends StatelessWidget {
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
      ),
      body: Column(
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
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
