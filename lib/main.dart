import 'package:flutter/material.dart';

import 'package:registrofinanceiro/user_transaction.dart';

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
  String value = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas Pessoais'),
        ),
//? ======================= COLUNA DO GRAFICO ===============
        body: SingleChildScrollView(
          //Esse componente só funciona aqui pois Esse column tem
          //um tamanho predefinido que são os limites do container e do
          //Widget TransactionUser. Por mais que o TransactionUser possa
          //crescer, ele ainda será um widget com limite. Aula 109.
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    elevation: 5,
                    //margin: EdgeInsets.all(4.0),
                    color: Colors.blue,
                    //borderOnForeground: false,
                  ),
                ),
                //* =============== Eixo PRINCIPAL DOS CARDS dentro de Column ============
                TransactionUser(),
              ]),
        ));
  }
}
