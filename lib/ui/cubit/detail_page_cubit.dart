import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/data/entity/product.dart';
import 'package:product_app/data/repo/productdao_repository.dart';

class DetailPageCubit extends Cubit<int> {
  DetailPageCubit() : super(1);

  var productRepo = ProductdaoRepository();

  void incrementQuantity() {
    emit(state + 1);
  }

  void decrementQuantity() {
    if (state > 1) {
      emit(state - 1);
    }
  }

  void resetQuantity() {
    emit(1);
  }

  Future<void> addProductToBasket(Product product, int quantity) async {
    await productRepo.addProductToBasket(product, quantity);
  }

  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playTickSound() async {
    await _audioPlayer.play(AssetSource('sound/tick.mp3'));
  }
}
