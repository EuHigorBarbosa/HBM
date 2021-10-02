import 'package:flutter/material.dart';
import 'package:shop/models/models.dart';
import 'package:shop/utils/utils.dart';

class ProductItem extends StatelessWidget {
  final Product productItem;
  ProductItem({Key? key, required this.productItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite),
              color: Theme.of(context).secondaryHeaderColor,
            ),
            title: Text(
              productItem.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).secondaryHeaderColor,
            ),
          )),
    );
  }
}
