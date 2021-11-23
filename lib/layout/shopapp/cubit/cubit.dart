import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/layout/shopapp/cubit/states.dart';
import 'package:flutter_nwesapp/model/categories_home_model.dart';
import 'package:flutter_nwesapp/model/shop_favorite_model.dart';
import 'package:flutter_nwesapp/model/shop_home_model.dart';
import 'package:flutter_nwesapp/model/shop_simple_model.dart';
import 'package:flutter_nwesapp/modules/shop_app/cart/cart_screen.dart';
import 'package:flutter_nwesapp/modules/shop_app/catecory/category_screen.dart';
import 'package:flutter_nwesapp/modules/shop_app/favorits/favotits_screen.dart';
import 'package:flutter_nwesapp/modules/shop_app/home/home_screen.dart';
import 'package:flutter_nwesapp/network/end_point.dart';
import 'package:flutter_nwesapp/network/remote/dio_helper.dart';
import 'package:flutter_nwesapp/shared/constans.dart';

class ShopCubit extends Cubit<ShopStates>{
  late int currentIndex=0;
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  Map<int,bool>favoriteList={};
void changeNavigation(int index){
  currentIndex = index;
  emit(ChangeBottomNav());
}
List <Widget> widget = [
  HomeScreen(),
  CategoryScreen(),
  CartScreen(),
  FavoritsScreen(),

];
ShopHomeModel ?shopHomeModels;
ShopCategoriesModel? shopCategoriesModel;
ShopFavoriteModel?shopFavoriteModel;
SimpleModel?simpleModel;
  void getFavoriteData()
  {
    emit(ShopGetFavoritesLoadingState());
    DioHelper.GetData(url: Favorites,token: token).then((value){
      shopFavoriteModel = ShopFavoriteModel.fromMap(value.data);
      //print(value.data.toString());
      emit(ShopGetFavoritesSuccessState());
    }).catchError((error){
      print(error.toString());
      print('favorites error => ${error.toString()}');
      emit(ShopGetFavoritesErorrState());
    });
  }
  void getHomeData()
  {
    emit(ShopGetHomeLoadingState());
    DioHelper.GetData(url: HOME,token: token).then((value){
      shopHomeModels = ShopHomeModel.fromMap(value.data);
      shopHomeModels!.data!.products!.forEach((element) {
        favoriteList.addAll({
          element.id:element.inFavorites,
        });
      });

      emit(ShopGetHomeSuccessState());
    }).catchError((error){
      print('home error => ${error.toString()}');
      emit(ShopGetHomeErorrState());
    });
  }

void getCategoriesData()
{
  emit(ShopGetCategoriesLoadingState());
  DioHelper.GetData(url: CATEGORIES,).then((value){
    shopCategoriesModel = ShopCategoriesModel.fromMap(value.data);
    //print(value.data.toString());

    emit(ShopGetCategoriesSuccessState());
  }).catchError((error){
    print(error.toString());
    print('categories error => ${error.toString()}');

    emit(ShopGetCategoriesErorrState());
  });
}
  void changeFavoriteData(int id)
  {
    favoriteList[id]=!favoriteList[id]!;
    emit(ShopChangeFavoritesDataLoadingState());
    DioHelper.PostData(
        url:Favorites,
        data:{
          'product_id':id,
        },
        token: token,
    ).then((value) {
      simpleModel=SimpleModel.formMap(value.data);
      log(simpleModel!.message);
      if(simpleModel!.status)
        {
          favoriteList[id]=!favoriteList[id]!;
        }else{
        getFavoriteData();
      }
      emit(ShopChangeFavoritesDataSuccessState());
    }).catchError((error){
      print(error.toString());
      favoriteList[id]=!favoriteList[id]!;
      print('favorite error => ${error.toString()}');
      emit(ShopChangeFavoritesDataErorrState());
    });
  }
}
