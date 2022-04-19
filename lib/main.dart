import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(Bytebank());
}

class Bytebank extends StatelessWidget {
  const Bytebank({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
      ),
      home: Dashboard(),
    );
  }
}
