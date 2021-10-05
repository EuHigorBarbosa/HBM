import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shop/data/dammy_data.dart';
import 'package:shop/models/models.dart';

class ProductListObservable with ChangeNotifier {
  List<Product> _itemsObservables = dummyProducts;

  //como é privada list temos que ter um get
  List<Product> get itemsObservables => [..._itemsObservables];

  void addProduct(Product product) {
    _itemsObservables.add(product);
    notifyListeners();
  }
}
