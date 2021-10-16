import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/models.dart';
import 'package:shop/utils/utils.dart';

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
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUCT_FORM, arguments: productItem);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Tem Certeza'),
                      content: Text('Quer remover o item do carrinho'),
                      actions: [
                        TextButton(
                          child: Text('Sim'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            //é o pop que vai retornar o bool do showDialog
                            //se true, então value é true e aí executa o if
                          },
                        ),
                        TextButton(
                          child: Text('Não'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        )
                      ],
                    );
                  },
                ).then((value) {
                  if (value ?? false) {
                    Provider.of<ProductListObservable>(context, listen: false)
                        .removeProductFromId(productItem);
                  }
                });
              }, //onPreessed
            ),
          ],
        ),
      ),
    );
  }
}
