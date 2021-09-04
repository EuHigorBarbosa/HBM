import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());

//Estou criando um widget MaterialApp e um Center
class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Versão Inicial'));
  }
}
