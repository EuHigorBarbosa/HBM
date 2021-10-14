import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product productReceived =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
        appBar: AppBar(
          title: Text(productReceived.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  productReceived.imageUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'R\$ ${productReceived.price}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  productReceived.description,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
