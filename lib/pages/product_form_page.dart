import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/models.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  late FocusNode _nameFocus;
  late FocusNode _priceFocus;
  late FocusNode _descriptionFocus;
  late FocusNode _urlFocus;
  final _imageUrlController = TextEditingController();
  //Esse controller foi criado para termos acesso à informação do que o usuario digitou
  //antes de submeter o formulário. Temos acesso a essa informação pelo get _imageUrlController.text.
  //Existem também o set value e o set
  final _formKey = GlobalKey<FormState>();
  //Existe esse negocio de chave glogal e existe esse negocio de tipo FormState
  //utilizando-se essa chave você pode manusear metodos do tipo
  //.currentState.save()
  //.currentWidget
  //.currentContext
  final _formData = Map<String, Object>();
  @override
  void initState() {
    super.initState();
    _nameFocus = FocusNode();
    _priceFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _urlFocus = FocusNode();
    _urlFocus.addListener(updateImage);
    //adicionei ouvinte para poder carregar a imagem apos o setfocus sair da caixa
    //de texto da url.
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _nameFocus.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _urlFocus.removeListener(updateImage);
    _urlFocus.dispose();

    super.dispose();
  }

  void _clearAllTextFiels() {
    _formKey.currentState?.reset();
    print('REset de todos os campos');
    _imageUrlController.clear();
    setState(() {}); //para haver o update da imagem
    FocusScope.of(context).requestFocus(_nameFocus);
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg') ||
        url.toLowerCase().endsWith('image=9');
    print('Retorno da validação do url = ${isValidUrl && endsWithFile}');
    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    print(
        'O tipo do _formKey.currentState é ${_formKey.currentState.runtimeType}');
    print(_formKey.currentState.toString());

    final isValid = _formKey.currentState?.validate() ?? true;

    print(
        'A validação foi do tipo boo valendo ${_formKey.currentState?.validate()}');
    print('O valor de isValid é? $isValid');

    if (isValid) {
      _formKey.currentState?.save();
      print('CONSIDERADO DADO VALIDO = isValid = $isValid');
      //o currentState pode não estar disponível, por isso devo utilizar essa ?
      //Quando dou um save nessa globalKey eu estou dando um save no meu Form - mais
      //precisamente na parte do FormState.
      //Quando uso o metodo .save eu estou dizendo:  Saves every [FormField] that is a descendant of this [Form].

      final newProduct = Product(
        id: Random().nextDouble().toString(),
        name: _formData['name'] as String,
        description: _formData['descritption'] as String,
        price: double.parse(_formData['price'] as String),
        imageUrl: _formData['imageUrl'] as String,
      );
      //print(newProduct.id);
    }
  }

  void updateImage() {
    //Ele simplesmente quer que o setState seja atualizado para que o
    //ImageNetwork carregue a url do TExtFild.

    //Ele vai carregar de acordo com um evento que é a mudança de foco.
    //O listener foi adicionado no _urlFocus. Toda vez que houver uma variação
    //no estado do _urlFocus então um setState irá ser executado por meio do
    //_urlFocus.listener(updateImage)

    setState(() {}); //Um setState vazio já é suficiente
  }

  @override
  Widget build(BuildContext context) {
    print('Construindo widget inicial build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            //Text('https://picsum.photos/250?image=9'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                focusNode: _nameFocus,
                decoration: InputDecoration(
                  labelText: 'Nome',
                  errorBorder: new OutlineInputBorder(
                    borderSide: new BorderSide(
                      color: Colors.orange,
                      width: 2.1,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.next,
                autofocus: true,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (name) {
                  if (name != null) {
                    _formData['name'] = name;
                  } else {
                    _formData['name'] = '';
                  }
                },
                validator: (_name) {
                  print('iniciada a validação do name');
                  final name = _name ?? '';
                  //aqui eu garanto que não receberei uma string nula
                  if (name.trim().isEmpty) {
                    return ' O nome não foi digitado. Ele é obrigatório.';
                  }

                  if (name.trim().length < 3) {
                    return 'Nome é obrigatório';
                  }
                  print('Está retornando null no NAME');
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                focusNode: _priceFocus,
                decoration: InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (price) {
                  if (price != null) {
                    _formData['price'] = price;
                  } else {
                    _formData['price'] = '';
                  }
                },
                validator: (_price) {
                  print('iniciada a validação do price');

                  final price = _price ?? '';
                  //aqui eu garanto que não receberei uma string nula
                  if (price.trim().isEmpty || price == '') {
                    return ' O valor não foi digitado. Ele é obrigatório.';
                  }

                  if (double.tryParse(price.trim()) == null) {
                    return 'O que foi digitado não é um número válido';
                  }

                  if (double.tryParse(price.trim()) != null &&
                      double.tryParse(price.trim())! <= 0.0) {
                    return 'Digite um número MAIOR que zero';
                  }
                  //falta validação de não colocar letras
                  print('Está retornando null no PRICE');
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                focusNode: _descriptionFocus,
                decoration: InputDecoration(labelText: 'Descrição'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_urlFocus);
                },
                onSaved: (description) {
                  if (description != null) {
                    _formData['descritption'] = description;
                  } else {
                    _formData['descritption'] = '';
                  }
                },
                validator: (_description) {
                  print('iniciada a validação do Description');

                  final description = _description ?? '';
                  //aqui eu garanto que não receberei uma string nula
                  if (description.trim().isEmpty) {
                    return ' A descrição não foi digitada. Ela é obrigatória.';
                  }

                  if (description.trim().length < 3) {
                    return 'Descrição é obrigatório';
                  }
                  print('Está retornando null no DESCRIPTION');

                  return null;
                },
              ),
            ),
            // FittedBox(
            //   child: Image.network(
            //     'https://picsum.photos/250?image=9',
            //     height: 100,
            //     width: 100,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextFormField(
                          focusNode: _urlFocus,
                          decoration: InputDecoration(
                            labelText: 'URL da imagem',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _imageUrlController.clear();
                                setState(() {});
                                FocusScope.of(context).requestFocus(_nameFocus);
                              },
                            ),
                          ),
                          textInputAction: TextInputAction
                              .done, //aqui vai haver a submissão do formulario
                          keyboardType: TextInputType.url,
                          controller: _imageUrlController,
                          onFieldSubmitted: (_) => _submitForm(),
                          //Esse underline aí é pra indicar que eu preciso do parametro para
                          //fazer minha assinatura de função ficar ok. Mas eu não usaria esse
                          //parametro internamente...é só uma opção, daria na mesma se eu colocasse
                          //um nome de argumento como foo mas eu poderia, ao ler, não pegar a ideia
                          //especifica desse uso nessa ocasião especifica
                          onSaved: (url) {
                            if (url != null) {
                              _formData['imageUrl'] = url;
                            } else {
                              _formData['imageUrl'] = '';
                            }
                          },
                          validator: (_imageUrl) {
                            print('iniciada a validação do _imageUrl');

                            final imageUrl = _imageUrl ?? '';
                            if (!isValidImageUrl(imageUrl)) {
                              return 'Informe url válida';
                            }
                            print('Está retornando null no URL');
                            return null;
                          }),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Container(
                        //width: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        //alignment: Alignment.center,
                        child: SizedBox.expand(
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: ((_imageUrlController.text.isEmpty) ||
                                    (!_imageUrlController.text.isEmpty &&
                                        !isValidImageUrl(
                                            _imageUrlController.text)))
                                ? Text(
                                    'Informe a Url\n\nToque para carregar\na imagem')
                                : Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text('Salvar'),
                  onPressed: _submitForm, //_submitForm(),
                ),
                TextButton(
                  child: Text('Limpe todos os campos'),
                  onPressed: () => _clearAllTextFiels.call(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
