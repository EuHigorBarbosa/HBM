import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/models.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'TEla do cart com ${cart.itemsNumber} de produtos = R\$${cart.totalAmount}'),
        ),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(25),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Chip(
                      backgroundColor: Theme.of(context).primaryColor,
                      label: Text(
                        'R\$1000',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                    //Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text('Comprar'),
                      style: TextButton.styleFrom(
                          textStyle:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
