class ShopUserModel{
  late bool status;
  late String message;
  late ShopUserDetails data;

  ShopUserModel.fromMap(Map<String, dynamic>jason)
  {
    status = jason['status'];
    message = jason['message'];
    data =ShopUserDetails.fromMap(jason['data']);
  }
}
class ShopUserDetails
{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String token;

  ShopUserDetails.fromMap(Map<String, dynamic>jason)
  {
    id = jason['id'];
    name = jason['name'];
    email = jason['email'];
    phone = jason['phone'];
    image = jason['image'];
    token = jason['token'];
  }
}