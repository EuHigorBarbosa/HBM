import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/models/models.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  void addItem(Product productAdded) {
    if (_items.containsKey(productAdded.id)) {
      _items.update(
        productAdded.id,
        (preExistingItem) => CartItem(
            id: preExistingItem.id,
            producId: preExistingItem.producId,
            name: preExistingItem.name,
            quantity: preExistingItem.quantity + 1,
            price: preExistingItem.price),
      );
    } else {
      _items.putIfAbsent(
        productAdded.id,
        () => CartItem(
          id: Random().nextDouble(),
          producId: productAdded.id,
          name: productAdded.name,
          quantity: 1,
          price: productAdded.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
