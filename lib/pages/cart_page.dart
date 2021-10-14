import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/components.dart';
import 'package:shop/models/models.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: true);
    final items = cart.items.values.toList();
    return Scaffold(
        appBar: AppBar(
          title: Consumer<Cart>(
            //Esse consumer está aqui mas sem muita precisao pois o listen: está true
            builder: (_, argConsumer, __) => Text(
                'TEla do cart com ${argConsumer.itemsNumber} de produtos = R\$${argConsumer.totalAmount}'),
          ),
        ),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15),
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
                        'R\$${cart.totalAmount}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight),
                      ),
                    ),
                    //Spacer(),
                    TextButton(
                      onPressed: () {
                        Provider.of<OrderList>(
                          context,
                          listen: false,
                        ).addOrder(cart);
                        cart.clear();
                      },
                      child: Text('Comprar'),
                      style: TextButton.styleFrom(
                          textStyle:
                              TextStyle(color: Theme.of(context).primaryColor)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, i) => CartItemWidget(cartItem: items[i]),
                itemCount: items.length,
              ),
            ),
          ],
        ));
  }
}
