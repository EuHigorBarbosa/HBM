import 'dart:math';

import 'package:flutter/material.dart';
import 'package:registrofinanceiro/transaction.dart';
import 'package:registrofinanceiro/transaction_form.dart';
import 'package:registrofinanceiro/transaction_list.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
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
// Aqui há uma declaração de um metodo que cria uma new variavel do
// tipo transaction e depois adiciona ela a um atributo
// da classe _TransactionUserState que guarda a lista de Transactions
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

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TransactionList(transactionsInsertedForRendering: _transactionsList),
      TransactionForm(funcaoAddNewTransactionOnSubmitUser: _addTransaction),
    ]);
  }
}
