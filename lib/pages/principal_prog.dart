import 'package:flutter/material.dart';
import 'package:flutter_poc/pages/top_Bar.dart';

class Principal extends StatelessWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 223, 223, 223),
        body: Column(
          children: [
            topBar(),
          ],
        ));
  }
}
