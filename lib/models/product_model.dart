// {
// "category":"Popular products",
// "thumbnail":"https"://serpapi.com/searches/691488c64a0898a45037bd9c/images/455043e53cdd3545b217e753671f26349c8bac0dd807c34d45292f059cb2d297.webp,
// "source_logo":"https"://serpapi.com/searches/691488c64a0898a45037bd9c/images/455043e53cdd3545b217e753671f26343c87ab843f53b17a501fc3ddee3c8e3b8be23962351bf45a.png,
// "source":"Best Buy",
// "title":PNY GeForce RTX 5080,
// "rating":4.7,
// "reviews":258,
// "price":$999.99,
// "extracted_price":999.99,
// "delivery":"Free delivery",
// "immersive_product_page_token":eyJlaSI6Ing0Z1VhYURESWNDUW05Y1A0WmVib1FZIiwicHJvZHVjdGlkIjoiIiwiY2F0YWxvZ2lkIjoiNDg5NTU0NjQ3NjAwMjQ4NDkxNiIsImhlYWRsaW5lT2ZmZXJEb2NpZCI6IjEyMTkwNTEyNDY4ODkyMTI3MDc0IiwiaW1hZ2VEb2NpZCI6IjU4OTczODI1ODUyOTIwNzkzMzIiLCJyZHMiOiJQQ182MDU1MzQwMzQxNTYzODI5MTU4fFBST0RfUENfNjA1NTM0MDM0MTU2MzgyOTE1OCIsInF1ZXJ5IjoicnR4KzUwODAiLCJncGNpZCI6IjYwNTUzNDAzNDE1NjM4MjkxNTgiLCJtaWQiOiI1NzY0NjI4NDMxNDE3OTg1NzUiLCJwdnQiOiJoZyIsInV1bGUiOm51bGwsImdsIjpudWxsLCJobCI6bnVsbH0=,
// "serpapi_link":"https"://serpapi.com/search.json?engine=google_immersive_product&page_token=eyJlaSI6Ing0Z1VhYURESWNDUW05Y1A0WmVib1FZIiwicHJvZHVjdGlkIjoiIiwiY2F0YWxvZ2lkIjoiNDg5NTU0NjQ3NjAwMjQ4NDkxNiIsImhlYWRsaW5lT2ZmZXJEb2NpZCI6IjEyMTkwNTEyNDY4ODkyMTI3MDc0IiwiaW1hZ2VEb2NpZCI6IjU4OTczODI1ODUyOTIwNzkzMzIiLCJyZHMiOiJQQ182MDU1MzQwMzQxNTYzODI5MTU4fFBST0RfUENfNjA1NTM0MDM0MTU2MzgyOTE1OCIsInF1ZXJ5IjoicnR4KzUwODAiLCJncGNpZCI6IjYwNTUzNDAzNDE1NjM4MjkxNTgiLCJtaWQiOiI1NzY0NjI4NDMxNDE3OTg1NzUiLCJwdnQiOiJoZyIsInV1bGUiOm51bGwsImdsIjpudWxsLCJobCI6bnVsbH0%3D
// }

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