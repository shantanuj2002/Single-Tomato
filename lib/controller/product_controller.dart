import 'package:flutter_app1/mainmodel/product_model.dart';
import 'package:flutter_app1/services/firebade_db.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  final products=<Product>[].obs;
  
  @override
  void onInit(){
    products.bindStream(FirestoreDb().getAllProducts());
    super.onInit();
  }
}