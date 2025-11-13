enum ProductListStatusType{
  uninitialized,
  loading,
  success,
  failure
}

class ProductListStatus {
  final ProductListStatusType type;
  final String? message;

  ProductListStatus(this.type, {this.message = ''});

  static ProductListStatus uninitialized = ProductListStatus(ProductListStatusType.uninitialized);
  static ProductListStatus loading = ProductListStatus(ProductListStatusType.loading);
  static ProductListStatus success = ProductListStatus(ProductListStatusType.success);

  static ProductListStatus failure(String message) {
    return ProductListStatus(ProductListStatusType.failure, message: message);
  }

}