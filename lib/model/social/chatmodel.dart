class ChatModel {
  String? senderUId;
  String? receiverUId;
  String? text;
  String? time;

  ChatModel({
    this.senderUId,
    this.receiverUId,
    this.text,
    this.time,
  });

  ChatModel.fromMap(Map<String, dynamic>jason){
    senderUId = jason['senderUId'];
    receiverUId = jason['receiverUId'];
    text = jason['text'];
    time = jason['time'];
  }
  Map<String,dynamic>toMap(){
    return{
      'senderUId':senderUId,
      'receiverUId':receiverUId,
      'text':text,
      'time':time,
    };
  }
}