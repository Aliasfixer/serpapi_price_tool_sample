class Product {
  String title;
  String? thumbnail;
  String source;
  double price;

  Product(
    this.title,
    this.thumbnail,
    this.source,
    this.price,
  );

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      map['title'],
      map['thumbnail'],
      map['source'],
      map['extracted_price']
    );
  }

  Map<String, dynamic> toMap(Product product) {
    return {
      'title': product.title,
      'thumbnail': product.thumbnail,
      'source': product.source,
      'extracted_price': product.price
    };
  }

}