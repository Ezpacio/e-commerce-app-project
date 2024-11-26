import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:product_app/data/entity/basket.dart';
import 'package:product_app/data/entity/basket_response.dart';
import 'package:product_app/data/entity/product.dart';
import 'package:product_app/data/entity/product_response.dart';

class ProductdaoRepository {
  String userName = 'sametgokkaya';

  List<Product> parseProductResponse(String response) {
    return ProductResponse.fromJson(json.decode(response)).product;
  }

  Future<List<Basket>> parseBasketResponse(String response) async {
    try {
      return BasketResponse.fromJson(json.decode(response)).basket;
    } catch (e) {
      return [];
    }
  }

  Future<List<Product>> productUpload() async {
    var url =
        Uri.parse("http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php");
    var response = await http.get(url);
    return parseProductResponse(response.body);
  }

  Future<void> addProductToBasket(Product product, int quantity) async {
    var basketItems = await uploadProductFromBasket();
    bool productExists = false;

    // Sepetteki ürün ile yeni eklenen ürünü karşılaştır
    for (var item in basketItems) {
      if (item.name == product.product_name) {
        productExists = true;

        int newQuantity = int.parse(item.quantity.toString()) + quantity;

        await deleteProductInBasket(item.basket_id);

        await addProductToDatabase(product, newQuantity);
        break;
      }
    }

    if (!productExists) {
      await addProductToDatabase(product, quantity);
    }
  }

  // Sepete Ürün Ekleme Fonksiyonu
  Future<void> addProductToDatabase(Product product, int quantity) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php");

    var data = {
      "ad": product.product_name,
      "resim": product.product_image,
      "kategori": product.category,
      "fiyat": product.product_price.toString(),
      "marka": product.brand,
      "siparisAdeti": quantity.toString(),
      "kullaniciAdi": userName
    };

    var response = await http.post(url, body: data);
    print(response.body);
  }

  // Sepetteki Ürünleri Listeleme
  Future<List<Basket>> uploadProductFromBasket() async {
    var url = Uri.parse(
        "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php");

    var data = {"kullaniciAdi": userName};
    var response = await http.post(url, body: data);
    return parseBasketResponse(response.body);
  }

  // Sepetteki Ürünleri Silme
  Future<void> deleteProductInBasket(int sepetId) async {
    var url = Uri.parse("http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php");

    var data = {"kullaniciAdi": "sametgokkaya", "sepetId": sepetId.toString()};
    var response = await http.post(url, body: data);
    // print(response.body);
  }
}
