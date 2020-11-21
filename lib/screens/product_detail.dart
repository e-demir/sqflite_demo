import 'package:flutter/material.dart';
import 'package:sqflitedemo/data/dbHelper.dart';
import 'package:sqflitedemo/models/Product.dart';

enum Options{update,delete}

class ProductDetail extends StatefulWidget{

  Product product;
  ProductDetail(this.product);


  @override
  State<StatefulWidget> createState() {
    return ProductDetailState(product);
  }

}

class ProductDetailState extends State {

  Product product;
  ProductDetailState(this.product);
  var dbHelper = DbHelper();
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail : ${product.name}"),
        actions: <Widget>[
         PopupMenuButton<Options>(
           onSelected: selectProcess ,
           itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
             PopupMenuItem<Options>(
               value: Options.delete,
               child: Text("Sil "),
             ),
             PopupMenuItem<Options>(
               value: Options.update,
               child: Text("Güncelle"),
             )
           ]

         )
        ],
      ),
      body: buildProductDetail(),

    );

  }

  buildProductDetail() {}

  void selectProcess(Options value) async {

    switch (value){
      case Options.delete:
        dbHelper.delete(product.id);
        Navigator.pop(context,true);
        break;
      default:
    }
  }
}