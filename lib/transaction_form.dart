import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) funcaoAddNewTransactionOnSubmitUser;
  //! Essa função tem o nome de onSubmit no arquivo do professor
  //ele construiu aqui um atributo variavel do tipo Function.
  //Esse atributo será utilizado no seu construtor. Então toda vez
  //que alguem quiser construir um Transaction_form ele vai ter que passar
  //uma função no mesmo modelo requerido no seu construtor

  TransactionForm({required this.funcaoAddNewTransactionOnSubmitUser});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

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

    widget.funcaoAddNewTransactionOnSubmitUser(title, value);
    //? Pra usar essa função funcaoAddNewTransactionOnSubmitUser aqui eu preciso
    //? de uma comunicação entre a classe _TransactionFormState e
    //? TransactionForm. Essa comunicação entre classes possibilita o uso de
    //? qualquer atributo da classe que não é a state. Essa comunicação
    //? se dá por meio dessa palavrinha widget. e aí vc coloca o atributo que quiser
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Card(
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
                style: Theme.of(context).textTheme.headline6,
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
      ),
    );
  }
}
