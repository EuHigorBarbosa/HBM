import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime)
      funcaoAddNewTransactionOnSubmitUser;
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
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    //Como submeteremos os dados mais de uma vez no programa vamos criar essa função
    //quando o user apertar o botão, então o construtor de
    // TransactionForm será chamado.
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    //Se acontecer de os valores dos textFields não forem válidos retorna nada.
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.funcaoAddNewTransactionOnSubmitUser(title, value, _selectedDate);
    //? Pra usar essa função funcaoAddNewTransactionOnSubmitUser aqui eu preciso
    //? de uma comunicação entre a classe _TransactionFormState e
    //? TransactionForm. Essa comunicação entre classes possibilita o uso de
    //? qualquer atributo da classe que não é a state. Essa comunicação
    //? se dá por meio dessa palavrinha widget. e aí vc coloca o atributo que quiser
  }

  _showDatePicker() {
    //o contex é recebido por herança assim como o widget. que é
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      print('Executado dentro da tela!');
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('Executado!!!!');
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
                controller: _titleController,
                autofocus: true,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(
                  // border: UnderlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.green, width: 3.0),
                  // ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.yellow, width: 7.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 3.0),
                  ),
                  labelText: 'Digite o Título',

                  //enabledBorder: OutlineInputBorder(),
                ),
              ),
              TextField(
                style: Theme.of(context).textTheme.headline6,

                //onChanged: (newValue) => value = newValue,
                controller: _valueController,
                onSubmitted: (value) => _submitForm(),
                //!MALANDRAGEM - uso da função sem parametro num lugar que pede parametro
                //! Tambem funciona se utilizarmos (_) => _submitForm()
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                //Esse comando cria o teclado númerico e faz com que funcione tanto
                //no android quantono ios
                decoration: InputDecoration(
                  labelText: 'Digite o valor (R\$)',
                ),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Text(_selectedDate == null
                        ? 'Nenhuma data selecionada'
                        : 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'),
                    ElevatedButton(
                      child: Text('Nova data'),
                      onPressed: _showDatePicker,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        textStyle: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: _submitForm,
                      child: Text(
                        'Nova Transação',
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
