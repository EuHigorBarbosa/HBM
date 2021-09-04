import 'package:flutter/material.dart';
import 'package:registrofinanceiro/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _transactions = [
    Transaction(
        date: DateTime.now(),
        id: 't1',
        title: 'Novo tênis de corrida',
        value: 310.76),
    Transaction(
      date: DateTime.now(),
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
    ),
  ];

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
