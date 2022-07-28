import 'package:flutter/material.dart';
import 'package:flutter_app1/widgets/cart_page.dart';
import 'package:get/get.dart';
import '../controller/cart_controller.dart';
import '../widgets/catalog_product.dart';

class CustomizedRate extends StatefulWidget {
  const CustomizedRate({
    Key? key,
  }) : super(key: key);
  @override
  State<CustomizedRate> createState() => _CustomizedRateState();
}

class _CustomizedRateState extends State<CustomizedRate> {
  //  final CartController controller=Get.find();
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customize"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          CatalogProducts(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  
                ),
                  onPressed: () {
                    if(cartController.products.isNotEmpty){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartProducts()));
                  }else{
                    Get.snackbar("Please Add item fisrt!!","Cart is Empty",duration: Duration(seconds: 2));
                  }},
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Go to Cart",style: TextStyle(fontSize: 28),),
                      Icon(Icons.arrow_forward_ios_rounded,color: Colors.greenAccent[700],size: 48,)
                    ],
                  )),
            ),
          )
        ],
      )),
    );
  }
}
