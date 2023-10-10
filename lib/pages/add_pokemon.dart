import 'package:flutter/material.dart';
import 'package:flutter_poc/models/pokemons.dart';

class Addpokemon extends StatelessWidget {
  final Pokemons? pokemon;
  const Addpokemon({super.key, required this.pokemon});
  @override
  Widget build(BuildContext context) {
    return Card(
      // Add elevation to give a shadow effect
      elevation: 5,
      // Add some padding
      margin: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          // Card's image
          Image.network(
            pokemon!.sprites.frontDefault,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // Card's content
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'This is some text inside the card. You can add more content here.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
