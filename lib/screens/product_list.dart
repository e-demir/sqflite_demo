
import 'package:flutter/material.dart';
import 'package:sqflitedemo/data/dbHelper.dart';
import 'package:sqflitedemo/models/Product.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return _ProductListState();
  }

}

class _ProductListState extends State {

  var dbHelper = DbHelper();
  List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    var futureProducts = dbHelper.getProducts();
    futureProducts.then((value) =>
    this.products = value
    );
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("Products"),
      ),
      body: buildProductList()
    );
  }

  ListView buildProductList() {
    ListView.builder(
      itemCount: productCount,
      itemBuilder: (BuildContext context, int position){
        return Card(
          color: Colors.pinkAccent,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.grey,child: Text("Product"),),
            title: Text(this.products[position].name),
            subtitle: Text(this.products[position].description),
            trailing: Text(this.products[position].unitPrice.toString()),
            onTap: (){},
          ),
        );
      }
      );
  }
}