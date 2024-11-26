import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:product_app/data/entity/product.dart';
import 'package:product_app/ui/components/InputComponent.dart';
import 'package:product_app/ui/components/extentions/color_extention.dart';
import 'package:product_app/ui/components/product_card.dart';
import 'package:product_app/ui/cubit/home_page_cubit.dart';
import 'package:product_app/ui/views/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    context.read<HomePageCubit>().productUpload();

    searchController.addListener(() {
      context.read<HomePageCubit>().filterProducts(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homePageAppBar(),
      body: Column(
        children: [
          searchTopInputSection(context),
          productListSection(),
        ],
      ),
    );
  }

  BlocBuilder<HomePageCubit, List<Product>> productListSection() {
    return BlocBuilder<HomePageCubit, List<Product>>(
      builder: (context, productList) {
        if (productList.isNotEmpty) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  childAspectRatio: (100 / 150),
                ),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  var product = productList[index];
                  return ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailPage(product: product);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        } else {
          return Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/animations/404.json",
                    repeat: true,
                    width: 200,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Sonuç bulunamadı',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Container searchTopInputSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          InputComponent(
            controller: searchController,
            onChanged: (value) {
              context.read<HomePageCubit>().filterProducts(value);
            },
          ),
        ],
      ),
    );
  }

  AppBar homePageAppBar() {
    return AppBar(
        title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Hoş Geldiniz'),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              shape: BoxShape.circle),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: const AssetImage('assets/images/portrait.jpg'),
            backgroundColor: Colors.grey[200],
          ),
        )
      ],
    ));
  }
}
