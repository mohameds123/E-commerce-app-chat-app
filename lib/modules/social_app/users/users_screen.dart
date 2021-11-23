import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:flutter_nwesapp/layout/social/cubit/cubit.dart';
import 'package:flutter_nwesapp/layout/social/cubit/state.dart';
import 'package:flutter_nwesapp/model/social/social_model.dart';
import 'package:flutter_nwesapp/modules/social_app/chat/chat_screen.dart';
class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
        listener: (context,state){},
        builder: (context,state){
          return Conditional.single(
              context: context,
              conditionBuilder:(context)=>SocialCubit.get(context).users.length>0,
              fallbackBuilder: (context)=>Center(child: CupertinoActivityIndicator(),),
              widgetBuilder: (context)=> Scaffold(
                appBar: AppBar(
                  backgroundColor:  Color.fromRGBO(60, 119, 183, 22),
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor:  Color.fromRGBO(60, 119, 183,230),
                    statusBarIconBrightness: Brightness.dark,
                  ),
                ),
                body: Column(
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft:Radius.circular(35.0),
                          //bottomRight:Radius.circular(20.0),
                        ),
                        color: Color.fromRGBO(60, 119, 183, 22),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Text(
                                'Chats',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: (){},
                                icon: Icon(
                                    Icons.search,
                                ),
                              color: Colors.white,
                              iconSize: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                        ),
                        child: ListView.separated(
                          itemBuilder: (context,index)=>UserItem(
                            userModel:SocialCubit.get(context).users[index],
                          ),
                          separatorBuilder: (context,index)=>Container(
                            width: double.infinity,
                            height: 1.0,
                            color: Colors.white,
                          ),
                          itemCount:SocialCubit.get(context).users.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          );
      }
    );
  }
}
class UserItem extends StatelessWidget {
  UserModel userModel;
  UserItem({
    required this.userModel,
});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context)=>ChatScreen(
                userModel: userModel
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              backgroundImage: NetworkImage(
                userModel.image!,
              ),
            ),
            SizedBox(
              width:15.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.name!,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  userModel.phone!,
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



