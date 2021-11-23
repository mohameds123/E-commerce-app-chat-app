import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_nwesapp/modules/social_app/social_login_screen/cubit/state.dart';
import 'package:flutter_nwesapp/shared/components/components.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLoginCubit extends Cubit<SocialLoginState>{
  SocialLoginCubit():super(SocialInitialLoginState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);
   void socialUserLogin({
  required String email,
  required String password,
}) {
    emit(SocialLoadingLoginState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      print(value.user!.uid);
      print(value.user!.email);
      emit(SocialLoginSuccessState());
    }).catchError((error){
      print('user Authentication Error=>${error.toString()}');
      emit(SocialLoginErrorState());
    });
  }
  GoogleSignInAccount? googleUser;

  GoogleSignInAuthentication? googleAuth;
  void googleSignIn()  {
    GoogleSignIn().signOut().then((value)async{
      googleUser = await GoogleSignIn().signIn();
      googleAuth = await googleUser!.authentication;

      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken,
        idToken: googleAuth!.idToken,
      );

      FirebaseAuth.instance.signInWithCredential(credential).then((value){
        print(value.user!.uid);
        print(value.user!.email);
        emit(SocialLoginSuccessState());
      }).catchError((error){
        print('user Authentication Error=>${error.toString()}');
        emit(SocialLoginErrorState());
      });
    });
  }
  //  void facebookSignIn() async {
  //  LoginResult? result= await FacebookAuth.instance.login();
  //
  //  OAuthCredential ?facebookAuthCredential = FacebookAuthProvider.credential(
  //    result.accessToken!.token,
  //  );
  //
  //  FirebaseAuth.instance.signInWithCredential(facebookAuthCredential).then((value){
  //    print(value.user!.uid);
  //    print(value.user!.email);
  //    user=value.user!;
  //    emit(SocialLoginSuccessState());
  //  }).catchError((error){
  //    print('User Authentication Error=>${error.toString()}');
  //    emit(SocialLoginErrorState());
  //  });
  // }
}