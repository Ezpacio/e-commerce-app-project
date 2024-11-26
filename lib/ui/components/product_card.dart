import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:product_app/data/entity/product.dart';
import 'package:product_app/ui/components/constants/appEnums.dart';
import 'package:product_app/ui/components/extentions/color_extention.dart';
import 'package:product_app/ui/components/image_component.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    super.key,
    required this.product,
    required this.onTap
  });

  final Product product;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 16),
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              height: 170,
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.backgroundColor
              ),
              clipBehavior: Clip.hardEdge,
              child: ImageComponent(
                imageType: ImageEnums.network,
                imageUrl: product.product_image,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        product.product_name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${NumberFormat.decimalPattern('tr').format(product.product_price)} \TL',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 36,
                  height: 36,
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: onTap,
                    icon: Icon(
                      Icons.add,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}