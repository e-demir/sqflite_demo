import 'package:flutter/material.dart';
import 'package:sqflitedemo/data/dbHelper.dart';
import 'package:sqflitedemo/models/Product.dart';

class ProductAdd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }

}

class ProductAddState extends State {

  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();
  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Add new product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDescription(),
            buildUnitPrice(),
            buildSaveButton()
          ],
        ),
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

  buildSaveButton() {
    return FlatButton(
      child: Text("Ekle"),
      onPressed: (){
        addProduct();
      },
    );
  }

  void addProduct() async {

  var result =  await dbHelper.insert(Product.withoutId(txtName.text, txtDescription.text, double.tryParse(txtUnitPrice.text)));
  Navigator.pop(context,true);

  }
  
  

}
