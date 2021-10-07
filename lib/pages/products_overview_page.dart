import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/components/components.dart';
import 'package:shop/models/product_list_observable.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverviewPage extends StatefulWidget {
  ProductOverviewPage({Key? key, required}) : super(key: key);

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    //!final ponteDeDados = Provider.of<ProductListObservable>(context);
    //Eu não estou mais coletando os dados do dammy_data e sim dos
    //itemsObservables que são a lista manipulada pelo subject da
    //classe ProductListObservable. Ele é quem notifica os listeners.
    //Para que eu não reconstrua toda a aplicação eu preciso utilizar
    //os CONSUMERS
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha loja2"),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                (selectedValue == FilterOptions.Favorite)
                    ? (_showFavoriteOnly = true)
                    : _showFavoriteOnly = false;
              });
            },
            /* //! Essa é parte da filtragem de favoritos da forma global
             onSelected: (FilterOptions selectedValue) {
              
              (selectedValue  == FilterOptions.Favorite)
                  ? ponteDeDados.showFavoriteOnly()
                  : ponteDeDados.showAll();
            },
            */
          ),
        ],
      ),
      body: ProductGrid(showFAvoriteOnly: _showFavoriteOnly),
    );
  }
}
