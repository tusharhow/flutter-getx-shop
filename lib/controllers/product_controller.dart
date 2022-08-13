import 'package:get/state_manager.dart';
import '../models/product_model.dart';
import '../services/remote_services.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  var cartCount = 0.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void addToCart(Product product) {
    cartCount++;
    update();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts();
      productList.value = products;
    } finally {
      isLoading(false);
    }
  }
}
