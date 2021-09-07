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
        actions: <Widget>[IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),

//? ======================= COLUNA DO GRAFICO ===============
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
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
          //* =============== Eixo PRINCIPAL DOS CARDS dentro de Column ============
          TransactionUser(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
