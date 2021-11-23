import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_nwesapp/model/social/chatmodel.dart';
import 'package:flutter_nwesapp/model/social/social_model.dart';
import 'package:flutter_nwesapp/shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
class ChatScreen extends StatelessWidget {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  UserModel userModel;
  ChatScreen({
    required this.userModel,
  });
  @override
  Widget build(BuildContext context){
    return BlocProvider(
      create: (BuildContext context) => ChatCubit()..getMessage(
          userModel: userModel
      ),
      child:BlocConsumer<ChatCubit,ChatState>(
        listener: (context,state){},
        builder: (context,state)=>Scaffold(
          appBar:AppBar(
            backgroundColor: Colors.blue,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.blue,
              statusBarIconBrightness: Brightness.dark,
            ),
            leading:Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
              ),
              child: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            title:StreamBuilder<DocumentSnapshot>(
              stream:_firebase.collection('users').doc(user!.uid).snapshots(),
              builder: (context,snapshot){
                if(snapshot.data!=null){
                  return Container(
                    child: Row(
                      children: [
                    CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(
                            userModel.image!,
                          ),
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          children: [
                            Text(
                              userModel.name!,
                            ),
                            Text(
                                snapshot.data!['status'],
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }else
                  return Container();
              },
            )
            // Row(
            //   children: [
            //     CircleAvatar(
            //       radius: 20.0,
            //       backgroundImage: NetworkImage(
            //         userModel.image!,
            //       ),
            //     ),
            //     SizedBox(
            //       width: 12.0,
            //     ),
            //     Column(
            //       children: [
            //         Text(
            //           userModel.name!,
            //         ),
            //       //   if(ChatCubit.get(context).messageController!=null)
            //       //   Padding(
            //       //     padding: const EdgeInsets.only(bottom: 5.0),
            //       //     child: Text(
            //       //         'typing...',
            //       //     ),
            //       //   ),
            //       //   if(ChatCubit.get(context).messageController==null)
            //       //     Padding(
            //       //       padding: const EdgeInsets.only(bottom: 5.0),
            //       //       child: Text(
            //       //         '',
            //       //       ),
            //       //     ),
            //       //   Text(
            //       //       userModel.status!,
            //       //   )
            //        ],
            //     ),
            //   ],
            // ),
            //backgroundColor: Colors.blue,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Conditional.single(
                  context: context,
                  widgetBuilder: (context)=>ListView.separated(
                    itemBuilder:(context,index){
                      ChatModel model = ChatCubit.get(context).messages[index];
                      if(model.senderUId == user!.uid)
                        return MyMessage(
                          model: model,
                        );
                      return UserMessage(
                        model: model,
                      );
                    },
                    separatorBuilder: (context,index)=>SizedBox(
                      height: 10.0,
                    ),
                    itemCount:ChatCubit.get(context).messages.length,
                  ),
                  conditionBuilder: (context)=>ChatCubit.get(context).messages.length>0,
                  fallbackBuilder: (context)=>Center(child: CupertinoActivityIndicator()),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller:ChatCubit.get(context).messageController,
                        decoration: InputDecoration(
                          // border: OutlineInputBorder(),
                          hintText: 'Type a message...',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    FloatingActionButton(
                      onPressed:(){
                        ChatCubit.get(context).sendMessage(userModel: userModel,);
                      },
                      child: Icon(Icons.send),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class UserMessage extends StatelessWidget {
  ChatModel model;
  UserMessage({
    required this.model,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(5.0),
            bottomEnd: Radius.circular(5.0),
            bottomStart: Radius.circular(5.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
            left: 8.0,
          ),
          child: Text(
            model.text!,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
class MyMessage extends StatelessWidget {
  ChatModel model;
  MyMessage({
   required this.model,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              right: 16.0
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(5.0),
                    bottomEnd: Radius.circular(5.0),
                    bottomStart: Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    left: 8.0,
                  ),
                  child: Text(
                    model.text!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ) ;
  }
}



