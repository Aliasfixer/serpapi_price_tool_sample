import 'dart:math';

import 'package:flutter/material.dart';
import 'package:serpapi_price_tool_sample/constants/view_status/product_list_status.dart';
import 'package:serpapi_price_tool_sample/models/product_model.dart';
import 'package:logging/logging.dart';
import 'package:serpapi_price_tool_sample/screens/home_screen/product_repository.dart';

class ProductProvider extends ChangeNotifier {
  final IProductRepository productRepository;
  final _log = Logger('ProductProvider');

  List<Product> _productList = [];
  List<List<Product>> _splitList = [];
  ProductListStatus _status = ProductListStatus.uninitialized;
  double _ave = 0;
  double _mode = 0;
  double _standardDeviation = 0;
  double _quarterPriceRange = 0;

  ProductListStatus get status => _status;
  List<Product> get productList => _productList;
  List<List<Product>> get splitList => _splitList;

  double get ave => _ave;
  double get mode => _mode;
  double get standardDeviation => _standardDeviation;
  double get quarterPriceRange => _quarterPriceRange;

  ProductProvider({required this.productRepository});

  Future<void> fetchProductList(TextEditingController controller, String apikey) async {
    _status = ProductListStatus.loading;
    notifyListeners();

    try {
      final result = await productRepository.fetchProductListFromGoogle({
        'engine': 'google_shopping_light',
        'q': controller.text,
        'api_key': apikey,
      });

      if (result.isSuccess && result.value != null) {
        _productList = result.value!;
        calculateAveAndMode();
        splitThePriceRange();
      } else {
        _status = ProductListStatus.failure(result.error ?? '无法加载商品列表');
        _log.warning('加载商品列表失败 ${result.error}');
      }
    } catch(e) {
      _status = ProductListStatus.failure(e.toString());
      _log.severe('加载商品列表失败: $e');
    }

    _status = ProductListStatus.success;
    notifyListeners();
  }

  void calculateAveAndMode() {
    if(_productList.isEmpty) return;
    double average = _productList.map((p) => p.price).reduce((a, b) => a + b) / _productList.length;
    final countMap = <double, int>{};
    for (var p in _productList) {
      countMap[p.price] = (countMap[p.price] ?? 0) + 1;
    }
    double modeNum = countMap.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;

    double sumSquaredDiffs = _productList
        .map((p) => pow(p.price - average, 2).toDouble())
        .reduce((a, b) => a + b);

    double deviation = sqrt(sumSquaredDiffs / (_productList.length - 1));

    _standardDeviation = deviation;
    _mode = modeNum;
    _ave = average;
  }

  void splitThePriceRange() {
    _quarterPriceRange = (_productList[_productList.length - 1].price - _productList[0].price) / 4;
    List<List<Product>> tempList = List.generate(4, (_) => []);
    for(var p in _productList) {
      int range = ((p.price - _productList[0].price) / quarterPriceRange).floor();
      range = range.clamp(0, 3);
      tempList[range].add(p);
    }
    _splitList = tempList;
  }
}