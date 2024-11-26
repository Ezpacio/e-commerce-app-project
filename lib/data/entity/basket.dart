class Basket {
  int basket_id;
  String name;
  String image;
  String category;
  int price;
  String brand;
  int quantity;
  String user_name;

  Basket({
    required this.basket_id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.brand,
    required this.quantity,
    required this.user_name
  });

  factory Basket.fromJson(Map<String, dynamic> json) {
    return Basket(
      basket_id: json["sepetId"] as int,
      name: json["ad"] as String,
      image: json["resim"] as String,
      category: json["kategori"] as String,
      price: json["fiyat"] as int,
      brand: json["marka"] as String,
      quantity: json["siparisAdeti"] as int,
      user_name: json["kullaniciAdi"] as String,
    );
  }
}
