import 'package:serpapi_price_tool_sample/models/product_model.dart';

import '../../service/network/network_config.dart';

abstract class IProductRepository {
  Future<Result<List<Product>>> fetchProductListFromGoogle(Map<String, dynamic> data);
  Future<Result<List<Product>>> fetchProductListFromAmazon();
}

final class ProductRepository implements IProductRepository {
  ProductRepository();

  @override
  Future<Result<List<Product>>> fetchProductListFromAmazon() {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Product>>> fetchProductListFromGoogle(Map<String, dynamic> data) async {
    final DioApiService net = DioApiService.instance;
    try {
      final Result result = await net.get('', data: data);
      print(result.value);

      if (result.isSuccess && result.value != null) {
        final res = result.value;
        final List<Map<String, dynamic>> tempList = (res['shopping_results'] ?? res as List).cast<Map<String, dynamic>>();
        List<Product> productList = tempList.map((map) => Product.fromMap(map)).toList();
        productList.sort((a, b) => a.price.compareTo(b.price));
        return Result.success(productList);
      } else {
        return Result.failure(result.error ?? 'Failed to fetch categories');
      }
    } catch(e) {
      return Result.failure(e.toString());
    }
  }
  
}