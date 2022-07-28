import 'package:flutter_app1/mainmodel/product_model.dart';
import 'package:get/get.dart';
class CartController extends GetxController {
  //Add a dict to store the product in cart
  var products = {}.obs;
  List<Product> namesProduct=[];
 void addProduct(Product product) {
    if (products.containsKey(product)) {
      products[product] += 1;
      
    } else {
      products[product] = 1;
    }
    
    Get.snackbar("Product Added", "You have added ${product.name} to cart",
        duration: Duration(seconds: 1), snackPosition: SnackPosition.TOP);
    
  }
  void removeProduct(Product product) {
    if (products.containsKey(product) && products[product] == 1) {
      products.removeWhere((key, value) => key == product,);
    } else {
      products[product] -= 1;
    }
    
  }

  get productSubtotal => products.entries
      .map((product) => product.key.price * product.value)
      .toList();

  final initialValue=0;
  get total => products.entries
      .map((product) => product.key.price * product.value)
      .toList()
      .fold(initialValue, (previousValue, productSubtotal) => productSubtotal+previousValue)
      .toString();

  
}
