class Product {
  int product_id;
  String product_name;
  int product_price;
  String product_image;
  String category;
  String brand;

  Product({
    required this.product_id,
    required this.product_name,
    required this.product_price,
    required this.product_image,
    required this.category,
    required this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      product_id: json["id"] as int,
      product_name: json["ad"] as String,
      product_price: json["fiyat"] as int,
      product_image: json["resim"] as String,
      category: json["kategori"] as String,
      brand:  json["marka"] as String,
    );
  }
}
