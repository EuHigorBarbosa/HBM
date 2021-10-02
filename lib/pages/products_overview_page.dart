import 'package:flutter/material.dart';
import 'package:shop/components/components.dart';
import 'package:shop/models/models.dart';
import '../data/dammy_data.dart';

class ProductOverviewPage extends StatelessWidget {
  final List<Product> loadedProduct = dummyProducts;
  ProductOverviewPage({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minha loja2')),
      body: GridView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: loadedProduct.length,
        //sliver = uma area que pode ser rolável.
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => ProductItem(productItem: loadedProduct[i]),
      ),
    );
  }
}
