class ShopCategoriesModel{
  late bool status;
  ShopCategoriesDetails? data;

  ShopCategoriesModel.fromMap(Map<String, dynamic>jason)
  {
    status = jason['status'];
    data =(jason['data'] !=null ? ShopCategoriesDetails.fromMap(jason['data']):null)!;
  }
}
class ShopCategoriesDetails
{
  List<ShopCategory>? data = [];
  ShopCategoriesDetails.fromMap(Map<String, dynamic>jason)
  {
    jason['data'].forEach((element) {
      data!.add(ShopCategory.fromMap(element));
    });
  }
}
class ShopCategory{
  late int id;
  late String image;
  late String name;

  ShopCategory.fromMap(Map<String, dynamic>jason)
  {
    id = jason['id'] ?? 0;
    image=jason['image']??'';
    name = jason['name'] ??'';
  }
}