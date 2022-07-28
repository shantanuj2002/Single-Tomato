import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app1/mainmodel/product_model.dart';

class FirestoreDb{
  // Initialize FireStore cloud
  final FirebaseFirestore _firebaseFirestore=FirebaseFirestore.instance;
  Stream<List<Product>>getAllProducts(){
    return  _firebaseFirestore.collection('customized')
    .snapshots().map((snapshot){
    return snapshot.docs.map((doc) =>Product.fromSnapshot(doc)).toList();
    });
  }
}