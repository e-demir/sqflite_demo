class Product{
  int id;
  String name;
  String description;
  double unitPrice;

  Product({this.id, this.name, this.description, this.unitPrice});
  Product.withoutId({this.name, this.description, this.unitPrice});

}