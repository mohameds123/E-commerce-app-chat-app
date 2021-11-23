import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/model/shop_user_model.dart';
import 'package:flutter_nwesapp/modules/shop_app/login/cubit/state.dart';
import 'package:flutter_nwesapp/network/end_point.dart';
import 'package:flutter_nwesapp/network/local/cache_helper.dart';
import 'package:flutter_nwesapp/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit():super(IntialLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);
   ShopUserModel? userModel;
  void UserLogin({
  required String email,
  required String password,
})
{
    emit(LoadingLoginState());
   DioHelper.PostData(
       url: LOGIN,
      data: {
         email:'email',
        password:'password',
      },
    ).then((value){
          userModel = ShopUserModel.fromMap(value.data);
          if(userModel!.status){
            print(userModel!.data.id);
            print(userModel!.data.email);
            print(userModel!.data.name);
            print(userModel!.status);
            print(userModel!.message);
            print(userModel!.data.token);

            CacheHelper.putData(key: 'userToken', value: userModel!.data.token);
            emit(LoginSuccessState());
          }
          else{
            emit(LoginSuccessState());
          }
    }).catchError((error){
      emit(LoginErrorState());
    });
  }
}