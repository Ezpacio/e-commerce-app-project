import 'package:product_app/data/entity/product.dart';

class ProductResponse {
  List<Product> product;
  int success;

  ProductResponse({
    required this.product,
    required this.success,
  });

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["urunler"] as List;

    int success = json["success"] as int;
    var product = jsonArray
        .map((jsonProductObject) => Product.fromJson(jsonProductObject))
        .toList();

    return ProductResponse(
      product: product,
      success: success,
    );
  }
}
