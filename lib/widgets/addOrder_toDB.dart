import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_app1/mainmodel/product_model.dart';
import 'package:get/get.dart';

import '../controller/cart_controller.dart';

class AddToDB extends StatelessWidget {
  const AddToDB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final CartController controller ;
    final controller = Get.put(CartController());
   // final CartController controller = Get.find();
    final Product product;
    String totalPay=controller.total;
  //  int quantity=0;
   // final int index;
    final customer = FirebaseAuth.instance.currentUser!;
    CollectionReference TodaysOrder =
        FirebaseFirestore.instance.collection("TodayOrder");
    Future<void> addOrder() {
     return TodaysOrder.doc(customer.displayName)
          .set({'product': controller.namesProduct.toSet().map((product) => product.name).toList(),
           "quantity":controller.products.values.toList().toString(),
           "total":controller.total,
           
           });
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              side: BorderSide(color: Colors.green)),
          onPressed: (){
            addOrder();
            Get.snackbar("Payment System is Under Progress","Your order is stored in Database",duration: Duration(seconds: 3),snackPosition: SnackPosition.TOP);
          },
           child: Text("Pay"+"   "+totalPay.toString(),style: TextStyle(fontSize: 32),))),
    );
  }
}
