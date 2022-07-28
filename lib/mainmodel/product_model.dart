import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final int price;
  final String image;
  final String measurement;

 Product({required this.name, required this.price, required this.image,required this.measurement});
 static Product fromSnapshot(DocumentSnapshot snap) {
    Product product11 =
        Product(
        name: snap['name'],
        price: snap['price'], 
        image: snap['image'],
        measurement:snap['measurement']
        );
    return product11;
  }
}
