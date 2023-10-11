import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PokeAPI POC'),
        ),
        body: const PokemonListScreen(),
      ),
    );
  }
}

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final Dio _dio = Dio();
  final List<dynamic> _pokemonList = [];
  int _offset = 0;
  final int _limit = 20;
  // Estilos para las Cards
  Map<String, Color> typeColors = {
    'Steel': const Color(0xFFD3D3D3),
    'Water': const Color(0xFF4169E1),
    'Bug': const Color(0xFFADFF2F),
    'Dragon': const Color(0xFF7B68EE),
    'Electric': const Color(0xFFFFFF00),
    'Ghost': const Color(0xFF8A2BE2),
    'Fire': const Color.fromARGB(255, 251, 33, 77),
    'Fairy': const Color(0xFFFF88EE),
    'Ice': const Color(0xFF00FFFF),
    'Fighting': const Color(0xFF8B0000),
    'Normal': const Color(0xFFE6E6FA),
    'Grass': const Color(0xFF32CD32),
    'Psychic': const Color(0xFFEE82EE),
    'Rock': const Color(0xFFCD853F),
    'Dark': const Color(0xFF2F4F4F),
    'Ground': const Color(0xFFDEB887),
    'Poison': const Color(0xFF9370DB),
  };

  @override
  void initState() {
    super.initState();
    fetchPokemonList();
  }

//fetch a la pokeAPI
  Future<void> fetchPokemonList() async {
    try {
      final response = await _dio.get(
        'https://pokeapi.co/api/v2/pokemon',
        queryParameters: {'offset': _offset, 'limit': _limit},
      );

      if (response.statusCode == 200) {
        setState(() {
          _pokemonList.addAll(response.data['results']);
          _offset += _limit;
        });
      }
    } catch (e) {
      print('Error en el servidor: $e');
    }
  }

  Color getBackgroundColor(String type) {
    return typeColors[type] ?? Colors.grey;
  }

  Color getBorderColor(String type) {
    return typeColors[type]?.withOpacity(0.8) ?? Colors.grey.withOpacity(0.8);
  }

//funcion para cargar mas pokemons al tocar le boton
  void _loadMorePokemons() {
    fetchPokemonList();
  }

  //funcion que te lleva a otro widget donde se muestran los detaller ,se pasa como parametro el nombre del pokemon
  void _showPokemonDetails(String pokemonName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PokemonDetailScreen(pokemonName: pokemonName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _pokemonList.length + 1,
        itemBuilder: (context, index) {
          if (index == _pokemonList.length) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _loadMorePokemons,
                child: const Text('Cargar mas'),
              ),
            );
          }
          // estilos generado por IA
          final pokemon = _pokemonList[index];
          String pokemonType = index % 17 == 0
              ? 'Poison'
              : index % 16 == 0
                  ? 'Ground'
                  : index % 15 == 0
                      ? 'Dark'
                      : index % 14 == 0
                          ? 'Rock'
                          : index % 13 == 0
                              ? 'Psychic'
                              : index % 12 == 0
                                  ? 'Grass'
                                  : index % 11 == 0
                                      ? 'Normal'
                                      : index % 10 == 0
                                          ? 'Fighting'
                                          : index % 9 == 0
                                              ? 'Ice'
                                              : index % 8 == 0
                                                  ? 'Fairy'
                                                  : index % 7 == 0
                                                      ? 'Fire'
                                                      : index % 6 == 0
                                                          ? 'Ghost'
                                                          : index % 5 == 0
                                                              ? 'Electric'
                                                              : index % 4 == 0
                                                                  ? 'Dragon'
                                                                  : index % 3 ==
                                                                          0
                                                                      ? 'Bug'
                                                                      : 'Water';
//detecto  el toque en la card y llamo a la funcion que me lleva a los detalles
          return GestureDetector(
            onTap: () => _showPokemonDetails(pokemon['name']),
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: getBackgroundColor(pokemonType),
                border: Border.all(
                  color: getBorderColor(pokemonType),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                leading: Image.network(
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',
                  width: 50,
                  height: 50,
                ),
                title: Text(
                  pokemon['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Este es el widget que muestra los detalles del pokemon
class PokemonDetailScreen extends StatelessWidget {
  final String pokemonName;

  const PokemonDetailScreen({super.key, required this.pokemonName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del pokemon: $pokemonName'),
      ),
      body: FutureBuilder(
        future: fetchPokemonDetails(pokemonName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            /* Verifico el estado de la llamada a la API y si es "waiting" muestro un 
                                                                     circulo de carga */
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final pokemon = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                //se muestra los datos del pokemon cn el nombre pasado por parametro
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tipo pokemon: ${pokemon?['types'][0]['type']['name']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Habilidad principal: ${pokemon?['abilities'][0]['ability']['name']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Adelante:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Image.network(pokemon?['sprites']['front_default']),
                  const SizedBox(height: 10),
                  const Text(
                    'Atras:',
                    style: TextStyle(fontSize: 18),
                  ),
                  Image.network(pokemon?['sprites']['back_default']),
                  const SizedBox(height: 10),
                  Text(
                    'Nro en la Pokédex: ${pokemon?['game_indices'][0]['game_index']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

//Otra funcion que me trae los detalles del pokemon usando el nombre del pokemon
  Future<Map<String, dynamic>> fetchPokemonDetails(String name) async {
    try {
      final Dio dio = Dio();
      final response = await dio.get('https://pokeapi.co/api/v2/pokemon/$name');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Falla al cargar  mas detalles del pokemon');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
