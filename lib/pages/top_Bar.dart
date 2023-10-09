import 'package:flutter/material.dart';

class topBar extends StatelessWidget {
  const topBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
          color: Colors.red, // El color que deseas para toda la fila
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.network(
                'https://www.freepnglogos.com/uploads/pokemon-letters-png-33.png',
                width: 180,
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
        ),
        Container(
          color: Colors.red, // El color que deseas para toda la fila
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'POC Flutter',
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'pokemons',
                    fontStyle: FontStyle.italic,
                    color: Color.fromARGB(255, 212, 195, 62)),
              ),
              Image.network(
                'https://www.freepnglogos.com/uploads/pokeball-png/pokeball-alexa-style-blog-pokemon-inspired-charmander-daily-8.png',
                width: 40,
              )
            ],
          ),
        ),
      ],
    );
  }
}
