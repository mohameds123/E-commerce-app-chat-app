class ShopFavoriteModel{
  late bool status;
  ShopFavoriteDetails? data;

  ShopFavoriteModel.fromMap(Map<String, dynamic>jason)
  {
    status = jason['status'];
    data =(jason['data'] !=null ? ShopFavoriteDetails.fromMap(jason['data']):null)!;
  }
}
class ShopFavoriteDetails
{
  late List<FavoriteProduct> ?data=[];
  ShopFavoriteDetails.fromMap(Map<String, dynamic>jason)
  {
    jason['data'].forEach((element)
    {
      data!.add(FavoriteProduct.fromMap(element));
    });
  }
}
class FavoriteProduct{
  late int id;
  late ShopProducts products;

  FavoriteProduct.fromMap(Map<String, dynamic>jason)
  {
    id = jason['id'] ?? 0;
    products=ShopProducts.fromMap(jason['product']);
  }
}
class ShopProducts{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ShopProducts.fromMap(Map<String, dynamic>jason)
  {
    id = jason['id'] ?? 0;
    price = jason['price'] ?? 0;
    oldPrice = jason['old_price'] ?? 0;
    discount = jason['discount'] ?? 0;
    image =jason['image']??'';
    name = jason['name'] ?? '';
    inFavorites = jason['in_favorites'] ?? false;
    inCart = jason['in_cart']??false;
  }
}