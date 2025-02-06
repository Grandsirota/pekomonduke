import 'package:flutter/material.dart';
import 'package:pokemondex/pokemonlist/models/pokemonlist_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemondetailView extends StatefulWidget {
  final PokemonListItem pokemonListItem;

  const PokemondetailView({super.key, required this.pokemonListItem});

  @override
  State<PokemondetailView> createState() => _PokemondetailViewState();
}

class _PokemondetailViewState extends State<PokemondetailView> {
  Map<String, dynamic>? _pokemonData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final response = await http.get(Uri.parse(widget.pokemonListItem.url));

    if (response.statusCode == 200) {
      setState(() {
        _pokemonData = jsonDecode(response.body);
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load Pokémon details');
    }
  }

  // ฟังก์ชันเพื่อเลือกสีหลอด stat ตามธาตุ
  Color _getStatColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.redAccent;
      case 'water':
        return Colors.blueAccent;
      case 'grass':
        return Colors.greenAccent;
      case 'electric':
        return Colors.yellowAccent;
      case 'ice':
        return Colors.lightBlueAccent;
      case 'poison':
        return Colors.purpleAccent;
      case 'ground':
        return Colors.brown;
      case 'psychic':
        return Colors.pinkAccent;
      case 'rock':
        return Colors.grey;
      case 'dark':
        return Colors.black87;
      case 'fairy':
        return Colors.pink[200]!;
      case 'fighting':
        return Colors.orangeAccent;
      case 'dragon':
        return Colors.indigoAccent;
      case 'ghost':
        return Colors.deepPurpleAccent;
      case 'steel':
        return Colors.blueGrey;
      case 'bug':
        return Colors.lightGreen;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B3A4B), // พื้นหลังน้ำเงินเข้ม
      appBar: AppBar(
        title: Text(
          widget.pokemonListItem.name.toUpperCase(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF144B59), // สีฟ้าคล้ายภูเขาน้ำแข็ง
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.black87,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image Container with frost effect
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blueAccent, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Image.network(
                        _pokemonData?['sprites']['other']['official-artwork']
                                ['front_default'] ??
                            '',
                        height: 250,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Pokémon Type with Ice-Themed Chips
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (_pokemonData?['types'] as List<dynamic>)
                          .map((type) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Chip(
                                  label: Text(
                                    type['type']['name'].toUpperCase(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  backgroundColor:
                                      Colors.lightBlueAccent.withOpacity(0.7),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 15),
                    // Height & Weight Information
                    Text(
                      "Height: ${_pokemonData?['height']}m  |  Weight: ${_pokemonData?['weight']}kg",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Base Stats Section Title
                    const Text(
                      'Base Stats',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Base Stats List
                    Column(
                      children: (_pokemonData?['stats'] as List<dynamic>)
                          .map((stat) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        stat['stat']['name'].toUpperCase(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 200, // จำกัดความกว้างสูงสุดของหลอด
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: LinearProgressIndicator(
                                          value: stat['base_stat'] / 100,
                                          backgroundColor: Colors.blueGrey[800],
                                          color: _getStatColor(
                                              _pokemonData?['types'][0]['type']
                                                  ['name']),
                                          minHeight: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 40,
                                      child: Text(
                                        stat['base_stat'].toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
