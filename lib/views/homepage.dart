import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import 'details_screen.dart';
import '../components/product_card.dart';

class HomePage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  
  HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Obx(() =>
            Text(productController.isLoading.value ? 'Loading...' : 'Shoppz')),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {},
                ),
                Positioned(
                  right: -5,
                  left: 40,
                  child: Obx(() => Text(
                        '${productController.cartCount.value}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: productController.productList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ProductTile(
                          product: productController.productList[index],
                          addCart: () {
                            productController.addToCart(
                                productController.productList[index]);
                          },
                          onTap: () {
                            Get.to(() => DetailsScreen(
                                  product: productController.productList[index],
                                 
                                ));
                          },
                        ),
                      );
                    });
              }
            }),
          )
        ],
      ),
    );
  }
}
