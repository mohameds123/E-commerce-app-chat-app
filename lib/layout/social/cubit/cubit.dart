import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/layout/social/cubit/state.dart';
import 'package:flutter_nwesapp/model/social/social_model.dart';
import 'package:flutter_nwesapp/modules/social_app/settings/settins_screen.dart';
import 'package:flutter_nwesapp/modules/social_app/users/users_screen.dart';
import 'package:flutter_nwesapp/shared/components/components.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialState>{
  int currentIndex=0;
  UserModel? userModel;
  SocialCubit():super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);
  void getUserData(){
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value){
          userModel=UserModel.fromMap(value.data()!);
          emit(GetUserDataSuccessState());
    });
  }
  void getUserDataRealTime(){
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .snapshots()
        .listen((value) {
      userModel = UserModel.fromMap(value.data()!);
      emit(GetUserDataSuccessState());
    });
  }
  final ImagePicker picker = ImagePicker();
  XFile?imageFile;
  void imagePicker(){
    picker.pickImage(source: ImageSource.gallery).then((value){
      imageFile=value;
      uploadProfileImage();
      emit(SocialImageState());
    });
  }
  void uploadProfileImage(){
    emit(SocialProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(imageFile!.path).pathSegments.last}')
        .putFile(File(imageFile!.path))
        .then((value){
      value.ref.getDownloadURL().then((value)
      {
        updateUserInfo(value);
        print(value);
      }).catchError((error) {
        emit(SocialProfilePhotoUrlErrorState());
      });
    }).catchError((error){
      emit(SocialProfilePhotoErrorState());
    });
  }
  void updateUserInfo(String imageUrl){
    userModel!.image=imageUrl;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update(userModel!.toMap()).then((value){
        emit(UpdateSocialProfileImageSuccessState());
    }).catchError((error){
      emit(UpdateSocialProfilePhotoErrorState());
        });
  }
  void changeNavigation(int index){
    currentIndex = index;
    emit(ChangeNavigationBar());
  }
  List <Widget> widget = [
    UsersScreen(),
   SettingScreen(),
  ];
  List<UserModel>users=[];
  void getUsers(){
    emit(GetUsersDataLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value){
          value.docs.forEach((element) {
            UserModel userModel=UserModel.fromMap(element.data());
            print('user image=>>${userModel.name}');
            print(element.data());
            if(userModel.uId!=user!.uid)
            users.add(userModel);
          });
          emit(GetUsersDataSuccessState());
    }).catchError((error) {
        emit(GetUsersDataErrorState());
    });
    }
  void updateUser(String status){
    userModel!.status=status;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update(userModel!.toMap()).then((value){
      emit(UpdateSocialStatusLoadingState());
    }).catchError((error){
      emit(UpdateSocialStatusSuccessState());
    });
  }
  }