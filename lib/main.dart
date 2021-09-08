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
      //? Para demonstrar que eu sei mexer com themeData eu vou criar um
      //? ThemeCentral para ExpesesApp, um tema central para form do tipo darkness
      //? e passar pontualmente um estilo para texfild do tipo AzeretMono
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
        ),

        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.red,
        accentColor: Colors.red,

        // Define the default font family.
        fontFamily: 'Quicksand',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'OpenSans'),

          //mudando de tema dark/light : https://www.youtube.com/watch?v=SEXlV2t8Kn4
        ),
      ),
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
    Navigator.of(context).pop();
    //Esse navigator serve para fechar o teclado quando clica no submit
    //Existe uma explicação muito interessante na aula 116
  }

  String value = ''; //?retirar pois acho que isso não está sendo usado

  _openTransactionFormModal(BuildContext context) {
    //Essa função vai simplesmente mostrar os textfilds para que o operador cadastre
    //uma nova transação
    //Esse build context no argumento dela eu não entendo pra que, o prof que colocou
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
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
        title: Text(
          'Despesas Pessoais',
          // style: TextStyle(
          //   fontFamily: 'OpenSans',
          // ),
        ),
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
                'Grafico1',
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
