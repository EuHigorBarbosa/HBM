import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsInsertedForRendering;

  TransactionList({required this.transactionsInsertedForRendering});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        child: transactionsInsertedForRendering.isEmpty
            ? Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Nenhuma despesa lançada',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Image.asset('assets/images/hhh.jpg'),
                  )
                ],
              )
            : ListView.builder(
                //caso não tenha elemento dentro do transactionList a imagem deve aparecer
                itemCount: transactionsInsertedForRendering.length,
                itemBuilder: (ctx, index) {
                  final tr = transactionsInsertedForRendering[index];
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
                }));
  }
}
