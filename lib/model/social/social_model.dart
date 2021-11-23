class UserModel{
  String? uId;
  String? phone;
  String? address;
  String? name;
  String? image;
  String? status;
  UserModel({
    this.name,
    this.address,
    this.phone,
    this.uId,
    this.image,
    this.status,
});
   UserModel.fromMap(Map<String,dynamic>jason){
     uId=jason['uId'];
     phone=jason['phone'];
     address=jason['address'];
     name=jason['name'];
     image=jason['image']!=null?jason['image']:'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg';
     status=jason['status'];
   }
   Map<String,dynamic>toMap(){
     return{
       'uId':uId,
       'phone':phone,
       'address':address,
       'name':name,
       'image':image,
       'status':status,
     };
   }
}