import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app1/mainmodel/product_model.dart';
import 'package:flutter_app1/widgets/addOrder_toDB.dart';
import 'package:flutter_app1/widgets/cart_total.dart';
import 'package:get/get.dart';
import '../controller/cart_controller.dart';

class CartProducts extends StatelessWidget {
  CartProducts({Key? key}) : super(key: key);
  final CartController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  height: 600,
                  child: ListView.builder(
                      itemCount: controller.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CartProductCard(
                          controller: controller,
                          product: controller.products.keys.toList()[index],
                          quantity: controller.products.values.toList()[index],
                          index: index,
                        );
                      }),
                ),
              ),
              CartTotal(),
              AddToDB()
            ],
          ),
        ),
      ),
    );
  }
}

class CartProductCard extends StatelessWidget {
  final CartController controller;
  final Product product;
  final int quantity;
  final int index;
  final CartController controller1 = Get.find();
  CartProductCard(
      {Key? key,
      required this.controller,
      required this.product,
      required this.quantity,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(product.image),
              ),
              Text(
                product.name,
                style: TextStyle(fontSize: 18),
              ),
              Text(product.price.toString()),
              IconButton(
                  onPressed: () {
                    controller.removeProduct(product);
                  },
                  icon: Icon(Icons.remove_circle)),
              Text('${quantity}'),
              IconButton(
                  onPressed: () {
                    controller.addProduct(product);
                  },
                  icon: Icon(Icons.add_circle))
            ],
          ),
        ),
      ),
    );
  }
}
