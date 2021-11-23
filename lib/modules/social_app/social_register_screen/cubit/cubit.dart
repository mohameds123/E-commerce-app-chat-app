import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/model/social/social_model.dart';
import 'package:flutter_nwesapp/modules/social_app/social_register_screen/cubit/state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState>{
  SocialRegisterCubit():super(SocialInitialRegisterState());
  static SocialRegisterCubit get(context)=>BlocProvider.of(context);
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  void socialUserRegister(
  ) {
  emit(SocialLoadingRegisterState());
  print('sss=>>>{${emailAddressController.text}');
  print('ppp=>>>{${passwordController.text}');
  FirebaseAuth.instance.createUserWithEmailAndPassword(
     email: emailAddressController.text,
     password: passwordController.text,
  ).then((value){
    print(value.user!.uid);
    print(value.user!.email);
    value.user!.sendEmailVerification();
    setUserData(
        uId: value.user!.uid,
    );
    emit(SocialRegisterSuccessState());
  }).catchError((error){
    print('User Authentication Error=>${error.toString()}');
    emit(SocialRegisterErrorState());
  });
  }
  void setUserData({
  required String uId,
}){
    emit(SetDataLoadingRegisterState());
    UserModel userModel = UserModel(
      uId: uId,
      name: nameController.text,
      phone: passwordController.text,
      address: addressController.text,
      status: 'status',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
          emit(SetDataRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SetDataRegisterErrorState());
    });
  }
}