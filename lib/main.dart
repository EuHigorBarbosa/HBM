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
                // margin: EdgeInsets.symmetric(
                //   horizontal: 15,
                //   vertical: 10,
                // ),
                //alignment: Alignment.center,
                //width: double.infinity,
                child: Card(
                  child: Text(
                    'Grafico2',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),

                  elevation: 5,
                  //margin: EdgeInsets.all(4.0),
                  color: Colors.blue,
                  //borderOnForeground: false,
                ),
              ),
              Column(
                children: <Widget>[
                  ..._transactions.map((tr) {
                    return Card(
                        child: Row(children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            )),
                        padding: EdgeInsets.all(30),
                        child: Text(
                          tr.value.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tr.title,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                            Text(tr.date.toString(),
                                style: TextStyle(color: Colors.grey),
                                textAlign: TextAlign.end),
                          ]),
                    ]));
                  }).toList(),
                ],
              )
            ]));
  }
}
