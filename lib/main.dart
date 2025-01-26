import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gallery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GalleryScreen(),
    );
  }
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar gambar
    final List<String> images = [
      'assets/images/gunung.jpg',
      'assets/images/gunung.jpg',
      'assets/images/gunung.jpg',
      'assets/images/gunung.jpg',
      'assets/images/gunung.jpg',
      'assets/images/gunung.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery App'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom dalam grid
          crossAxisSpacing: 8.0, // Jarak antar kolom
          mainAxisSpacing: 8.0, // Jarak antar baris
        ),
        padding: const EdgeInsets.all(8.0),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigasi ke detail gambar
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDetailScreen(
                    imagePath: images[index],
                  ),
                ),
              );
            },
            child: Image.asset(
              images[index],
              fit: BoxFit.cover, // Atur gambar agar pas di grid
            ),
          );
        },
      ),
    );
  }
}

class ImageDetailScreen extends StatelessWidget {
  final String imagePath;

  const ImageDetailScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Detail'),
      ),
      body: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}
