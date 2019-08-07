import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/datas/cart_product.dart';
import 'package:ecommerce_app/datas/product_data.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {

  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  Widget _buildContent() {

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: cartProduct == null ?
      FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection("products").document(
            cartProduct.category).collection("items")
            .document(cartProduct.pid)
            .get(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            cartProduct.productData = ProductData.fromDocument(snapshot.data);
            return _buildContent();
          }else {
            return Container(
              height: 70.0,
              child: CircularProgressIndicator(),
              alignment: Alignment.center,
            );
          }
        },
      ) :
      _buildContent(),
    );
  }
}
