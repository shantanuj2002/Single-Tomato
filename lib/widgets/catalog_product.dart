import 'package:flutter_app1/controller/product_controller.dart';
import 'package:flutter_app1/widgets/cart_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/controller/cart_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CatalogProducts extends StatelessWidget {
  final productController = Get.put(ProductController());
  CatalogProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Flexible(
          child: ListView.builder(
              itemCount: productController.products.length,
              itemBuilder: (BuildContext context, int index) {
                return CatalogProductCard(index: index);
              }),
        ));
  }
}

class CatalogProductCard extends StatelessWidget {
  final cartController = Get.put(CartController());
  final ProductController productController = Get.find();
  final int index;
  CatalogProductCard({Key? key, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundImage:
                  NetworkImage(productController.products[index].image),
            ),
            Column(
              children: [
                Text(
                  productController.products[index].name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '${productController.products[index].price}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(productController.products[index].measurement),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all()),
              child: TextButton(
                  onPressed: () {
                    cartController.namesProduct
                        .add(productController.products[index]);
                    cartController
                        .addProduct(productController.products[index]);
                  },
                  child: Row(
                    children: [
                      Text("Add",
                          style:
                              TextStyle(color: Colors.red[700], fontSize: 24)),
                      Icon(
                        Icons.add,
                        color: Colors.red[700],
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
