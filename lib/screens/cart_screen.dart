import 'package:ecommerce_app/models/cart_model.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/tiles/cart_tile.dart';
import 'package:ecommerce_app/widgets/cart_price.dart';
import 'package:ecommerce_app/widgets/discount_card.dart';
import 'package:ecommerce_app/widgets/ship_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int qtd = model.products.length;
                return Text(
                  "${qtd ?? 0} ${qtd == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17.0),
                );
              },
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
          // ignore: missing_return
          builder: (context, child, model) {
            if(model.isLoading && UserModel.of(context).isLoggedIn()) {
              return Center(child: CircularProgressIndicator(),);
            }else if(!UserModel.of(context).isLoggedIn()) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.remove_shopping_cart, size: 80.0, color: Theme.of(context).primaryColor,),
                    SizedBox(height: 16.0,),
                    Text("Faça login para adicionar produtos!",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0,),
                    RaisedButton(
                      child: Text("Entrar",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      },
                    ),
                  ],
                ),
              );
            }else if(model.products == null || model.products.length == 0) {
              return Center(
                child: Text("Nenhum produto no carrinho!",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }else {
              return ListView(
                children: <Widget>[
                  Column(
                    children: model.products.map(
                        (product) {
                          return CartTile(product);
                        }
                    ).toList(),
                  ),
                  DiscountCard(),
                  ShipCard(),
                  CartPrice(() async {
                    String orderId = await model.finishOrder();
                    if(orderId != null) {
                      print(orderId);
                    }
                  }),
                ],
              );
            }
          }
      ),
    );
  }
}
