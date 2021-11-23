import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/model/shop_user_model.dart';
import 'package:flutter_nwesapp/modules/shop_app/register/cubit/states.dart';
import 'package:flutter_nwesapp/network/end_point.dart';
import 'package:flutter_nwesapp/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit():super(InitialRegisterStates());
  static RegisterCubit get(context)=>BlocProvider.of(context);
  ShopUserModel? userModel;
  void userRegister({
    required String userName,
    required String emailAddress,
    required String phone,
    required String password,
  })
  {
    emit(RegisterLoadingstates());
    DioHelper.PostData(
        url: Register,
        data:{
          'name':userName,
          'email':emailAddress,
          'phone':phone,
          'password':password,
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

        emit(RegisterSuccess());
      }
      else{
        emit(RegisterUnsuccess());
      }
    })
        .catchError((error){
      emit(RegisterError());
    });
  }
}