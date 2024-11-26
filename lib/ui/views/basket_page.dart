import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:product_app/data/entity/basket.dart';
import 'package:product_app/ui/components/basket_card.dart';
import 'package:product_app/ui/components/extentions/color_extention.dart';
import 'package:product_app/ui/cubit/basket_page_cubit.dart';
import 'package:product_app/ui/views/bottom_bar_page/bottom_bar_page.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  void initState() {
    super.initState();
    context.read<BasketPageCubit>().uploadProductFromBasket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        title: BlocBuilder<BasketPageCubit, List<Basket>>(
            builder: (context, basketProductList) {
          return Text(
            'Sepetim (${basketProductList.length})',
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          );
        }),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<BasketPageCubit, List<Basket>>(
            builder: (context, basketProductList) {
              if (basketProductList.isNotEmpty) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: ListView.builder(
                      itemCount: basketProductList.length,
                      itemBuilder: (context, index) {
                        var basket = basketProductList[index];
                        return BasketCardComponent(
                          basket: basket,
                          onPressed: () {
                            context
                                .read<BasketPageCubit>()
                                .deleteProductFromBasket(basket.basket_id)
                                .then((_) {
                              context
                                  .read<BasketPageCubit>()
                                  .uploadProductFromBasket();
                            });
                          },
                        );
                      },
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        "assets/animations/sleep.json",
                        repeat: true,
                        width: 220,
                      ),
                      const Text(
                        'Sepetinizde ürün yok!',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        width: 180,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const BottomBarPage(),
                                ),
                                (Route<dynamic> route) => false);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Ürünleri İncele',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                CupertinoIcons.chevron_right,
                                color: AppColors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24)),
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Toplam:',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    BlocBuilder<BasketPageCubit, List<Basket>>(
                      builder: (context, basketProductList) {
                        double totalPrice = 0;
                        for (var element in basketProductList) {
                          totalPrice += element.price * element.quantity;
                        }
                        return Text(
                          '${NumberFormat.decimalPattern('tr').format(totalPrice)}\ TL',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sepeti Onayla',
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Icon(
                          Icons.check,
                          color: AppColors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
