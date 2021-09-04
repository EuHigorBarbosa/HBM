import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());

//Estou criando um widget MaterialApp e um scafold
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas Pessoais'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              color: Colors.pink,
              //padding: EdgeInsets.all(10.0),
              //margin: EdgeInsets.all(100.0),
              //alignment: Alignment.center,
              //width: double.infinity,
              child: Card(
                child: Text(
                  'Grafico',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),

                elevation: 5,
                //margin: EdgeInsets.all(4.0),
                color: Colors.blue,
                //borderOnForeground: false,
              ),
            ),
            Card(
              child: Text('Lista de Transações'),
            )
          ],
        ));
  }
}
