import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/components.dart';
import 'package:shop/data/dammy_data.dart';
import 'package:shop/models/models.dart';
import 'package:shop/models/product_list_observable.dart';

class ProductOverviewPage extends StatelessWidget {
  ProductOverviewPage({Key? key, required}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductListObservable>(context);
    final List<Product> loadedProducts = dummyProducts;
    provider.itemsObservables;
    //Eu não estou mais coletando os dados do dammy_data e sim dos
    //itemsObservables que são a lista manipulada pelo subject da
    //classe ProductListObservable. Ele é quem notifica os listeners.
    //Para que eu não reconstrua toda a aplicação eu preciso utilizar
    //os CONSUMERS
    return Scaffold(
      appBar: AppBar(title: Text('Minha loja2')),
      body: GridView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        //sliver = uma area que pode ser rolável.
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => ProductItem(productItem: loadedProducts[i]),
      ),
    );
  }
}
