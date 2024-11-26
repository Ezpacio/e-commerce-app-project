import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_app/data/entity/basket.dart';
import 'package:product_app/ui/components/constants/appEnums.dart';
import 'package:product_app/ui/components/extentions/color_extention.dart';
import 'package:product_app/ui/components/image_component.dart';

class BasketCardComponent extends StatelessWidget {
  BasketCardComponent({
    super.key,
    required this.basket,
    required this.onPressed,
  });
  final Basket basket;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(26),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(6),
            child: ImageComponent(
              imageType: ImageEnums.network,
              imageUrl: basket.image,
              boxfit: BoxFit.contain,
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                basket.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    NumberFormat.decimalPattern('tr').format(basket.price),
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    '  / Adet',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Text(
                    'Adet : ',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${basket.quantity}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    'Toplam : ',
                    style: TextStyle(
                      color: Colors.grey[850],
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    NumberFormat.decimalPattern('tr')
                        .format(basket.price * basket.quantity),
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              CupertinoIcons.delete,
              color: Colors.red[300],
            ),
          )
        ],
      ),
    );
  }
}
