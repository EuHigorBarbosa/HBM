import 'package:flutter/material.dart';
import 'package:registrofinanceiro/transaction.dart';
import 'package:intl/intl.dart';

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
  String title = '';
  String value = '';
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
//? ======================= COLUNA DO GRAFICO ===============
        body: Column(
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  elevation: 5,
                  //margin: EdgeInsets.all(4.0),
                  color: Colors.blue,
                  //borderOnForeground: false,
                ),
              ),
              //* =============== COLUNA PRINCIPAL DOS CARDS ============
              Column(
                children: <Widget>[
                  ..._transactions.map((tr) {
                    return Card(
                        child: Row(children: <Widget>[
                      // ==================== CONTAINER DOS NUMEROS
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            )),
                        padding: EdgeInsets.all(30),
                        // ================   NUMEROS DO PREÇO  =======
                        child: Text(
                          'R\$${tr.value.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.purple,
                          ),
                        ),
                      ),
//======================== COLUMN DOS TEXTOS =====================
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ================  TITULO DO CARD  =======
                            Text(
                              tr.title,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            // ================  DATA DO CARD  ======================
                            Text(
                              DateFormat('d MMM y').format(tr.date),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ]),
                    ]));
                  }).toList(),
                ],
              ),
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (newTitle) => title = newTitle,
                        decoration:
                            InputDecoration(labelText: 'Digite o Título'),
                      ),
                      TextField(
                        onChanged: (newValue) => value = newValue,
                        decoration:
                            InputDecoration(labelText: 'Digite o valor (R\$)'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print(
                                  'O valor de title é: $title e o valor do gasto é: $value \n');
                            },
                            child: Text('Nova Transação'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]));
  }
}
