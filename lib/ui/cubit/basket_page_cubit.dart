import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/data/entity/basket.dart';
import 'package:product_app/data/repo/productdao_repository.dart';

class BasketPageCubit extends Cubit<List<Basket>> {
  BasketPageCubit() : super(<Basket>[]);

  var productRepo = ProductdaoRepository();

  Future<void> uploadProductFromBasket() async {
    var productList = await productRepo.uploadProductFromBasket();
    emit(productList);
  }

  Future<void> deleteProductFromBasket(int sepetId) async {
    await productRepo.deleteProductInBasket(sepetId);
    await productRepo.uploadProductFromBasket();
  }

}
