import 'package:flutter/material.dart';
import 'package:pokemondex/pokemonlist/views/pokemonlist.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:
            const Color(0xFF1B3A4B), // สีเข้มสไตล์น้ำแข็งที่ให้บรรยากาศหนาวเย็น
        scaffoldBackgroundColor: const Color(0xFFE0F7FA), // สีฟ้าขาวคล้ายหิมะ
        fontFamily: 'Pokemon', // ใช้ฟอนต์เดิม
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            ' Pokémon Dex',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              letterSpacing: 2.0,
              color: Colors.white, // สีตัวอักษรเน้นความเย็นและหิมะ
            ),
          ),
          backgroundColor:
              const Color(0xFF144B59), // สีฟ้าเข้มคล้ายภูเขาน้ำแข็ง
          centerTitle: true,
          elevation: 12,
          shadowColor: Colors.black87,
        ),
        body: Stack(
          children: [
            // พื้นหลังภาพหิมะ
            Positioned.fill(
              child: Image.asset(
                'assets/image/freljord_background.jpg',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.4),
                colorBlendMode: BlendMode.darken,
              ),
            ),
            const PokemonList(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF1B3A4B),
          selectedItemColor: const Color(0xFFADD8E6), // สีน้ำแข็งอ่อน
          unselectedItemColor: Colors.white54,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Dex',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
          ],
        ),
      ),
    );
  }
}
