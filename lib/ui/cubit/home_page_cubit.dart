import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/data/entity/product.dart';
import 'package:product_app/data/repo/productdao_repository.dart';

class HomePageCubit extends Cubit<List<Product>> {
  HomePageCubit() : super(<Product>[]);

  var productRepo = ProductdaoRepository();

  List<Product> allProducts = [];

  Future<void> productUpload() async {
    var productList = await productRepo.productUpload();
    allProducts = productList;
    emit(productList);
  }

  Future<void> filterProducts(String query) async {
    if (query.isEmpty) {
      emit(allProducts);
    } else {
      final filteredProducts = allProducts
          .where((product) =>
              product.product_name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(filteredProducts);
    }
  }
  
}
