import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:product_app/data/entity/product.dart';
import 'package:product_app/ui/components/constants/appEnums.dart';
import 'package:product_app/ui/components/extentions/color_extention.dart';
import 'package:product_app/ui/components/image_component.dart';
import 'package:product_app/ui/cubit/detail_page_cubit.dart';

class DetailPage extends StatefulWidget {
  Product product;

  DetailPage({required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          productPicture(context),
          productDetailSection(context),
        ],
      ),
    );
  }

  Container productDetailSection(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(30),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          productInfoSection(context),

          //* Sepete Ürün Ekle Butonu
          addProductButton(context),
        ],
      ),
    );
  }

  Column productInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Name
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.product.product_name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
            Text(
              '${NumberFormat.decimalPattern('tr').format(widget.product.product_price)} \TL',
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),

        // Etiket (Category Name, Cargo)
        Wrap(
          spacing: 8.0,
          children: [
            Chip(
              label: Text(widget.product.category),
              backgroundColor: Colors.blue[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            ),
            Chip(
              label: const Text('Kargo Bedava'),
              backgroundColor: Colors.amber[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),

        // Adet Seçimi
        Row(
          children: [
            BlocBuilder<DetailPageCubit, int>(
              builder: (context, quantity) {
                return IconButton(
                  onPressed: quantity > 1
                      ? () {
                          context.read<DetailPageCubit>().decrementQuantity();
                        }
                      : null,
                  icon: const Icon(Icons.remove),
                  style: IconButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      disabledBackgroundColor: Colors.grey[200]),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: BlocBuilder<DetailPageCubit, int>(
                builder: (context, quantity) {
                  return Text(
                    '$quantity',
                    style: const TextStyle(fontSize: 20),
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<DetailPageCubit>().incrementQuantity();
              },
              style:
                  IconButton.styleFrom(backgroundColor: AppColors.primaryColor),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }

  Column addProductButton(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Ara Toplam: ',
              style: TextStyle(fontSize: 16),
            ),
            BlocBuilder<DetailPageCubit, int>(
              builder: (context, quantity) {
                return Text(
                  '${NumberFormat.decimalPattern('tr').format(quantity * widget.product.product_price)}\ TL',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextButton(
            onPressed: () async {
              final quantity = context.read<DetailPageCubit>().state;
              context
                  .read<DetailPageCubit>()
                  .addProductToBasket(widget.product, quantity);
              await context.read<DetailPageCubit>().playTickSound();

              // Dialog'u gösteriyoruz
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // Dialog içeriği
                  return Dialog(
                    backgroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset(
                            "assets/animations/cart.json",
                            repeat: true,
                            width: 260,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );

              // 3 saniye sonra dialog'u kapatıyoruz
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context).pop(); // Dialog'u kapatır
              });
            },
            child: const Text(
              'Sepete Ekle',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        )
      ],
    );
  }

  Row productPicture(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: ImageComponent(
            imageType: ImageEnums.network,
            imageUrl: widget.product.product_image,
            boxfit: BoxFit.contain,
            width: 100,
            height: 300,
          ),
        ),
      ],
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(CupertinoIcons.chevron_left),
        onPressed: () {
          context.read<DetailPageCubit>().resetQuantity();
          Navigator.pop(context);
        },
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      title: Text(widget.product.product_name),
    );
  }
}
