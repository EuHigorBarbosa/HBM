import 'package:flutter/material.dart';
import 'package:registrofinanceiro/transaction_form.dart';

import 'dart:math';
import 'package:registrofinanceiro/transaction.dart';
import 'package:registrofinanceiro/transaction_list.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _transactionsList = [
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

  dynamic _addTransaction(String argTitle, double argValue) {
    final newTransaction = Transaction(
        date: DateTime.now(),
        id: Random().nextDouble().toString(),
        title: argTitle,
        value: argValue);

    //? --- Esse set serve para atualizar o estado do componente stateful que é o TransactionUser
    //? -- Logicamente será chamado depois de haver sido criado um objeto do tipo List<Transaction>
    setState(() {
      _transactionsList.add(newTransaction);
    });
    //Aqui há uma modificação do atributo da classe _TransactionUserState por meio de
    //uma adição.
  }

  String value = ''; //?retirar pois acho que isso não está sendo usado

  _openTransactionFormModal(BuildContext context) {
    //Essa função vai simplesmente mostrar os textfilds para que o operador cadastre
    //uma nova transação
    //Esse build context no argumento dela eu não entendo pra que, o prof que colocou
    showModalBottomSheet(
        context: context,
        builder: (ctxAleatorio) {
          return TransactionForm(
              funcaoAddNewTransactionOnSubmitUser: _addTransaction);
          //! Essa parte aqui fui eu que coloquei...o professor pois null mas
          //! não entendo pq o dele funcionou com null - Aula 113
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            //! Eu não tenho a minima noção do que é o uso do context aqui e pq funcionou
            //! sendo que
            icon: Icon(Icons.add),
          ),
        ],
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
                'Grafico',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              elevation: 5,
              //margin: EdgeInsets.all(4.0),
              color: Colors.blue,
              //borderOnForeground: false,
            ),
          ),
          //* =============== Eixo PRINCIPAL DOS CARDS dentro de Column ============
          TransactionList(transactionsInsertedForRendering: _transactionsList),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
