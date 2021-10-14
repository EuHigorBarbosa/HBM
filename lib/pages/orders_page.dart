import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/components.dart';
import 'package:shop/components/order_widget.dart';
import 'package:shop/models/models.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of<OrderList>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Meus Pedidos'),
        ),
        body: ListView.builder(
          itemCount: orders.itemsCount,
          itemBuilder: (ctx, i) => OrderWidget(
            order: orders.items[i],
          ),
        ));
  }
}
