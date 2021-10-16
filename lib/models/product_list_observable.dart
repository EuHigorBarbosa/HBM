import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dammy_data.dart';
import 'package:shop/models/models.dart';

class ProductListObservable with ChangeNotifier {
  final _baseUrl = 'https://shop-higor-default-rtdb.firebaseio.com/';

  List<Product> _itemsObservables = dummyProducts;

  //como é privada list temos que ter um get
  //esses ... é pra fazer uma copia dos dados originais.
  //De acordo com o valor de _showFavoriteOnly eu vou ter como dados
  //os favoritados ou não favoritados.
  List<Product> get itemsObservables => [..._itemsObservables];

  List<Product> get favoriteItems =>
      _itemsObservables.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _itemsObservables.length;
  }

  void saveProductFromDataForm(Map<String, Object> dataFromForm) {
    print('\n Metodo SAveProductDataForm foi acionado');

    bool hasId = dataFromForm['id'] != null;
    // ============ Variáveis a serem salvas =================
    print('\n Valores Transferidos a serem salvos');
    print('name: ${dataFromForm['name']}');
    print('price: ${dataFromForm['price']}');

    print('description: ${dataFromForm['description']}');

    print('imageUrl: ${dataFromForm['imageUrl']}');
    // ============ Variáveis a serem salvas =================

    //Verifica se não tem id. Se não tiver id então cria um id com o
    //random e add normalmente.
    //Se tiver um id então tem que verificar se é o caso de se fazer um
    //update (pois se o id já existir então tem que fazer o update dos dados)
    //ou se é o caso de só add mesmo

    final newProduct = Product(
      id: hasId
          ? dataFromForm['id'].toString()
          : Random().nextDouble().toString(),
      name: dataFromForm['name'].toString(),
      description: dataFromForm['description'].toString(),
      price: double.parse(dataFromForm['price'].toString()),
      imageUrl: dataFromForm['imageUrl'].toString(),
    );

    if (hasId) {
      //chama metodo que faz o update do id
      updateIdOnProduct(newProduct);
    } else {
      //chama metodo que add o produto já com o id
      addProduct(newProduct);
    }
  }

  void updateIdOnProduct(Product productToUpdateOrAdd) {
    int indexToKnowWherePutTheNew = _itemsObservables
        .indexWhere((item) => item.id == productToUpdateOrAdd.id);
    //Se o indexTo... for -1 então o id é novo e o produto deve ser add
    //Se o indexTo.... for >=0 então é o caso de se fazer o update
    //mas com certeza será >= pois se
    if (indexToKnowWherePutTheNew >= 0) {
      _itemsObservables[indexToKnowWherePutTheNew] = productToUpdateOrAdd;
      //Se o indexTo...for 2 então o _itemObservables[2] deve ser sobrescrito pelo productToUpdate
      notifyListeners();
    } else if (indexToKnowWherePutTheNew == -1) {
      //se
      addProduct(productToUpdateOrAdd);
    }
  }

  void removeProductFromId(Product productToRemove) {
    int indexToKnowWherePutTheNew =
        _itemsObservables.indexWhere((item) => item.id == productToRemove.id);
    //Se o indexTo... for -1 então o id é novo e o produto deve ser add
    //Se o indexTo.... for >=0 então é o caso de se fazer o update
    //mas com certeza será >= pois se
    if (indexToKnowWherePutTheNew >= 0) {
      _itemsObservables.removeAt(indexToKnowWherePutTheNew);
      //Se o indexTo...for 2 então o _itemObservables[2] deve ser sobrescrito pelo productToUpdate
      notifyListeners();
    } else if (indexToKnowWherePutTheNew == -1) {
      //ainda não programado

    }
  }

  void addProduct(Product product) {
    var urlMinha = Uri.parse('$_baseUrl/products.json');

    final postProduct = http.post(
      urlMinha,
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite
        },
        //o id não envia pois estou aqui adicionando um novo produto
      ), //converte para json
    );
    postProduct.then((response) {
      print('Printado depois que a resposta voltar do FireBase');
      print(jsonDecode(response.body));
      //Quando recebemos a resposta nós recebemos um json com string inicial 'name'

      final idReceivedFromFirebase = jsonDecode(response.body)['name'];
      _itemsObservables.add(
        Product(
          name: product.name,
          id: idReceivedFromFirebase,
          price: product.price,
          description: product.description,
          imageUrl: product.imageUrl,
          isFavorite: product.isFavorite,
        ),
      ); //aqui há o salvamento dos dados em memoria
      notifyListeners();
    });
    print('Print depois do post sem esperar a resposta');
  }
}

/* //! Essa parte é a solução de filtro de favoritos global. Ela tem uma parte no botão OnSelected do menu
class ProductListObservable with ChangeNotifier {
  List<Product> _itemsObservables = dummyProducts;
  bool _showFavoriteOnly = false;

  //como é privada list temos que ter um get
  //esses ... é pra fazer uma copia dos dados originais.
  //De acordo com o valor de _showFavoriteOnly eu vou ter como dados
  //os favoritados ou não favoritados.
  List<Product> get itemsObservables {
    if (_showFavoriteOnly) {
      return _itemsObservables.where((prod) => prod.isFavorite).toList();
    }
    return [..._itemsObservables];
  }

  void addProduct(Product product) {
    _itemsObservables.add(product);
    notifyListeners();
  }

  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }
}
*/