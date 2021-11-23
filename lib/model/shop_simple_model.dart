class SimpleModel{
  late bool status;
  late String message;

  SimpleModel.formMap(Map<String,dynamic>jason){
    status=jason['status'];
    message=jason['message'];
  }
}