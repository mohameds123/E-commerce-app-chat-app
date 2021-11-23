import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_nwesapp/layout/social/cubit/cubit.dart';
import 'package:flutter_nwesapp/layout/social/cubit/state.dart';
import 'package:flutter_nwesapp/modules/social_app/social_login_screen/socialloginscreen.dart';
import 'package:flutter_nwesapp/shared/components/components.dart';
class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
      listener: (context,state){},
      builder: (context,state)=>Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('4B4B4B'),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('4B4B4B'),
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body:Container(
          decoration: BoxDecoration(
            color: HexColor('4B4B4B'),
          ),
          child: Column(
            children: [
                 Expanded(
                   child: Container(
                     decoration: BoxDecoration(
                       color: HexColor('4B4B4B'),
                     ),
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(SocialCubit.get(context).imageFile==null)
                        CircleAvatar(
                          radius: 100.0,
                          backgroundImage: NetworkImage(
                              SocialCubit.get(context).userModel!.image!,
                          ),
                      ),
                        if(SocialCubit.get(context).imageFile!=null)
                            CircleAvatar(
                              radius: 150.0,
                                backgroundImage:FileImage(
                                  File(SocialCubit.get(context).imageFile!.path),
                                ),
                          ),
                              TextButton(
                                  onPressed: (){
                                  SocialCubit.get(context).imagePicker();
                              },
                              child: Text(
                                  'upload',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: HexColor('FD9310'),
                                  ),
                                ),
                              ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: HexColor('FD9310'),
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Icon(Icons.person),
                                               SizedBox(
                                                 width: 10.0,
                                               ),
                                               Text(
                                                  '${SocialCubit.get(context).userModel!.name}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                  fontSize: 20.0
                                                ),
                                              ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_city),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'live in - ${SocialCubit.get(context).userModel!.address}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.phone),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'contact info - ${SocialCubit.get(context).userModel!.phone}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 120.0,
                                    ),
                                    Row(
                                      children: [
                                        MaterialButton(
                                          onPressed: (){
                                            FirebaseAuth.instance.signOut().then((value){
                                              navigateAndFinish(
                                                context: context,
                                                widget: SocialLoginScreen(),
                                              );
                                            });
                                          },
                                          child: Text(
                                            'LogOut',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.logout,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                   ),
                 ),
              SizedBox(
                height: 20.0,
              ),

            ],
          ),
        ),
        ),
      );
  }
}