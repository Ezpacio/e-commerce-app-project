import 'package:product_app/data/entity/basket.dart';

class BasketResponse {
  List<Basket> basket;
  int success;

  BasketResponse({
    required this.basket,
    required this.success,
  });

  factory BasketResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["urunler_sepeti"] as List;

    int success = json["success"] as int;
    var basket = jsonArray
        .map((jsonProductObject) => Basket.fromJson(jsonProductObject))
        .toList();

    return BasketResponse(
      basket: basket, 
      success: success,
    );
  }
}
