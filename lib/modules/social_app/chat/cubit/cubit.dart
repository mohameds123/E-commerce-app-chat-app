import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/model/social/chatmodel.dart';
import 'package:flutter_nwesapp/model/social/social_model.dart';
import 'package:flutter_nwesapp/modules/social_app/chat/cubit/state.dart';
import 'package:flutter_nwesapp/shared/components/components.dart';

class ChatCubit extends Cubit<ChatState>{
  TextEditingController messageController =TextEditingController();
  ChatCubit():super(ChatInitialState());
  static ChatCubit get(context) => BlocProvider.of(context);
   void sendMessage({
  required UserModel userModel,
}){
     emit(SentMessageStateLoading());
     ChatModel chatModel=ChatModel(
       senderUId: user!.uid,
       receiverUId: userModel.uId,
       text: messageController.text,
       time: DateTime.now().toString(),
     );
     FirebaseFirestore.instance
         .collection('users')
         .doc(user!.uid)
         .collection('chat')
         .doc(userModel.uId)
         .collection('message')
         .add(chatModel.toMap())
         .then((value){
           saveMessage(
               messageId:value.id,
               userModel: userModel,
               chatModel: chatModel,
           );
           messageController.clear();
        emit(SentMessageStateSuccess());
     }).catchError((error) {
      emit(SentMessageStateError());
     });
     }
     void saveMessage({
       required UserModel userModel,
       required ChatModel chatModel,
       required String messageId,
  }){
       FirebaseFirestore.instance
           .collection('users')
           .doc(userModel.uId)
           .collection('chat')
           .doc(user!.uid)
           .collection('message')
           .doc(messageId)
           .set(chatModel.toMap())
           .then((value){
         emit(SentMessageStateSuccess());
       }).catchError((error) {
         print(error.toString());
         emit(SentMessageStateError());
       });

     }
     List<ChatModel>messages=[];
     void getMessage({
  required UserModel userModel,
}){
       emit(ChatStateLoading());
       FirebaseFirestore.instance
           .collection('users')
           .doc(user!.uid)
           .collection('chat')
           .doc(userModel.uId)
           .collection('message')
          .orderBy('time',descending: false,)
           .snapshots()
           .listen((event) {
             messages=[];
             event.docs.forEach((element) {
               messages.add(ChatModel.fromMap(element.data()));
               emit(ChatStateSuccess());
             });
       });
     }
   }
