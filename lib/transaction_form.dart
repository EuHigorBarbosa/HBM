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

  _submitForm() {
    //Como submeteremos os dados mais de uma vez no programa vamos criar essa função
    //quando o user apertar o botão, então o construtor de
    // TransactionForm será chamado.
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    //Se acontecer de os valores dos textFields não forem válidos retorna nada.
    if (title.isEmpty || value <= 0) {
      return;
    }

    funcaoAddNewTransactionOnSubmitUser(title, value);
  }

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
              autofocus: true,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(labelText: 'Digite o Título'),
            ),
            TextField(
              //onChanged: (newValue) => value = newValue,
              controller: valueController,
              onSubmitted: (value) => _submitForm(),
              //!MALANDRAGEM - uso da função sem parametro num lugar que pede parametro
              //! Tambem funciona se utilizarmos (_) => _submitForm()
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //Esse comando cria o teclado númerico e faz com que funcione tanto
              //no android quantono ios
              decoration: InputDecoration(labelText: 'Digite o valor (R\$)'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
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
