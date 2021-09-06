import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  // O "filho" transaction_form precisa conversar com seu pai (o transaction_User)
  // É necessario pois o pai chama o filho diretamente
  // Vamos fazer essa comunicação por meio de uma função.
  // O pai vai chamar o filho por meio de uma função que já está
  // declarada no pai.
  final void Function(String, double) funcaoAddNewTransactionOnSubmitUser;
  //ele construiu aqui um atributo variavel do tipo Function.
  //Esse atributo será utilizado no seu construtor. Então toda vez
  //que alguem quiser construir um Transaction_form ele vai ter que passar
  //uma função no mesmo modelo requerido no seu construtor

  TransactionForm({required this.funcaoAddNewTransactionOnSubmitUser});
  //O construtor utiliza de uma função como argumento. Isso é brilhante pois
  //

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              //onChanged: (newTitle) => title = newTitle,
              //Não teremos o evento onCheged pois vou usar o controller
              controller: titleController,
              decoration: InputDecoration(labelText: 'Digite o Título'),
            ),
            TextField(
              //onChanged: (newValue) => value = newValue,
              controller: valueController,
              decoration: InputDecoration(labelText: 'Digite o valor (R\$)'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    //quando o user apertar o botão, então o construtor de
                    // TransactionForm será chamado.
                    final title = titleController.text;
                    final value = double.tryParse(valueController.text) ?? 0.0;
                    funcaoAddNewTransactionOnSubmitUser(title, value);
                  },
                  child: Text('Nova Transação'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
