import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/pages/top_bar.dart';
import 'package:flutter_poc/models/pokemons.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

Pokemons? pokemon;
int pokemonId = 0;
int pokemonId2 = 0;

class _PrincipalState extends State<Principal> {
  @override
  void initState() {
    super.initState();
    getPokemon();
  }

  Future<void> getPokemon() async {
    pokemonId++;
    final response =
        await Dio().get('https://pokeapi.co/api/v2/pokemon/$pokemonId');
    pokemon = Pokemons.fromJson(response.data);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
      body: ListView(
        children: [
          const topBar(),
          //create a  card where the pokemon will be displayed, and in the footer show some info  about
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Card(
              color: Colors.red[200],
              elevation: 10,
              child: Column(children: <Widget>[
                Text(
                  pokemon?.name ?? 'No data',
                  style: const TextStyle(
                      fontSize: 50, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (pokemon != null) ...[
                      Image.network(
                        pokemon!.sprites.frontDefault,
                        scale: 0.50,
                      ),
                    ]
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: getPokemon, child: const Icon(Icons.navigate_next)),
    );
  }

  //cargar lista de pokemones

  /*
   Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 10,
              child: Column(children: <Widget>[
                Text(
                  pokemon?.name ?? 'No data',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (pokemon != null) ...[
                      Image.network(
                        pokemon!.sprites.frontDefault,
                        height: 200,
                      ),
                      Image.network(pokemon!.sprites.backDefault),
                    ]
                  ],
                ),
              ]),
            ),
          ),*/
}
