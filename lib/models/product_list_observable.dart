import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/data/dammy_data.dart';
import 'package:shop/models/models.dart';

class ProductListObservable with ChangeNotifier {
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

  void addProduct(Product product) {
    _itemsObservables.add(product);
    notifyListeners();
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