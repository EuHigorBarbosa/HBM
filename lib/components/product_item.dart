import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/models.dart';
import 'package:shop/utils/utils.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productItem = Provider.of<Product>(
      context,
      listen: false,
      // esse atributo diz que se houver uma modificação nos daddos então será ouvido pelos listeners
      //estando false não será ouvido e renderizado por se modificar, exceto nos consumers.
    );
    final cart = Provider.of<Cart>(context, listen: false);
    //?Essa linha de codigo faz com que o dado productItem esteja disponível para toda a classe.
    //? Mas tem uma forma de fazer que é mais interessante pois ganha-se produtividade. É utilizando
    //? o CONSUMER
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_DETAIL,
                arguments: productItem,
              );
            },
            child: Image.network(
              productItem.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                onPressed: () {
                  productItem.toggleFavorite();
                },
                icon: Icon(productItem.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border),
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            title: Text(
              productItem.name,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addItem(productItem);
                print('adicionou ${cart.itemsCount}');
              },
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).secondaryHeaderColor,
            ),
          )),
    );
  }
}
