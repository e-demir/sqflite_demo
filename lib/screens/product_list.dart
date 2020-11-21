
import 'package:flutter/material.dart';
import 'package:sqflitedemo/data/dbHelper.dart';
import 'package:sqflitedemo/models/Product.dart';
import 'package:sqflitedemo/screens/product_add.dart';
import 'package:sqflitedemo/screens/product_detail.dart';

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
    getProducts();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text("Products"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: "Add new product",
        onPressed: (){goToProductAddPage();},
      ),
    );
  }

  ListView buildProductList() {
     return ListView.builder(
      itemCount: productCount,
      itemBuilder: (BuildContext context, int position){
        return Card(
          color: Colors.orangeAccent,
          elevation: 6.0,
          child: ListTile(
            leading: CircleAvatar( backgroundColor: Colors.white,child: Icon(Icons.settings_input_composite),),
            title: Text(this.products[position].name,style: TextStyle(fontSize: 23.0),),
            subtitle: Text(this.products[position].description,style: TextStyle(fontSize: 15.0),),
            trailing: Text(this.products[position].unitPrice.toString()),
            onTap: (){goToDetail(this.products[position]);},
          ),
        );
      }
      );
  }

 void goToProductAddPage() async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductAdd(),));
    if(result != null){
      if(result){
        getProducts();
      }
    }
 }

  void getProducts() async {
    var futureProducts = dbHelper.getProducts();
    futureProducts.then((data){
      this.products = data;
      productCount = data.length;
      print(this.products);
      print(productCount);
    });
  }

  void goToDetail(Product product) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product),));
    if(result != null){
      if(result){
        getProducts();
      }
    }
  }
}