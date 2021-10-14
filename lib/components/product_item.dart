import 'package:flutter/material.dart';
import 'package:shop/models/models.dart';

class ProductItem extends StatelessWidget {
  final Product productItem;
  const ProductItem({Key? key, required this.productItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(productItem.imageUrl),
      ),
      title: Text('Produto'),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
