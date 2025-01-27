import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MyApp adalah StatefulWidget untuk mengelola tema aplikasi
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // State untuk tema (mode terang atau gelap)
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gallery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: GalleryScreen(
        onToggleTheme: () {
          setState(() {
            isDarkMode = !isDarkMode; // Ubah tema saat tombol ditekan
          });
        },
      ),
    );
  }
}

// GalleryScreen adalah layar utama yang menampilkan galeri gambar
class GalleryScreen extends StatefulWidget {
  final VoidCallback onToggleTheme; // Callback untuk mengubah tema

  const GalleryScreen({super.key, required this.onToggleTheme});

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  // Daftar gambar
  final List<String> images = [
    'assets/images/gunung.jpg',
    'assets/images/gunung.jpg',
    'assets/images/gunung.jpg',
    'assets/images/gunung.jpg',
    'assets/images/gunung.jpg',
    'assets/images/gunung.jpg',
  ];

  // Status 'liked' untuk setiap gambar
  final List<bool> likedStatus = List<bool>.filled(6, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme, // Ubah tema saat tombol ditekan
          ),
        ],
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
            child: Stack(
              children: [
                // Gambar
                Positioned.fill(
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                ),
                // Ikon 'like'
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: IconButton(
                    icon: Icon(
                      likedStatus[index]
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: likedStatus[index] ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        likedStatus[index] = !likedStatus[index];
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ImageDetailScreen adalah layar detail untuk menampilkan gambar
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
        child: Hero(
          tag: imagePath,
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}
