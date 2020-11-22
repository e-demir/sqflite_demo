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

  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();
  Product product;
  ProductDetailState(this.product);
  var dbHelper = DbHelper();

  @override
  void initState() {
    txtName.text = product.name;
    txtDescription.text = product.description;
    txtUnitPrice.text = product.unitPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail : ${product.name}"),
        actions: <Widget>[
         PopupMenuButton<Options>(
           onSelected: selectProcess,
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

  buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescription(),
          buildUnitPrice(),
        ],
      ),
    );


  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Product Name"),
      controller: txtName,
    );
  }

  buildDescription() {
    return TextField(
      decoration: InputDecoration(labelText: "Product Description"),
      controller: txtDescription,
    );
  }

  buildUnitPrice() {
    return TextField(
      decoration: InputDecoration(labelText: "Product Price"),
      controller: txtUnitPrice,
    );
  }


  void selectProcess(Options options) async {
    switch (options){
      case Options.delete:
        dbHelper.delete(product.id);
        Navigator.pop(context,true);
        break;
      case Options.update:
        dbHelper.update(Product(product.id, txtName.text,txtDescription.text, double.tryParse(txtUnitPrice.toString())));
        Navigator.pop(context,true);
        break;
      default:
    }
  }
}