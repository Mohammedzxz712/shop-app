import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_1/models/shop_app/change_favorites_model.dart';
import 'package:shop_app_1/models/shop_app/get_favorites_model.dart';
import 'package:shop_app_1/models/shop_app/home_model.dart';
import 'package:shop_app_1/models/shop_app/login_model.dart';
import 'package:shop_app_1/moduls/shop_app/categories_screen/categories_screen.dart';
import 'package:shop_app_1/moduls/shop_app/favorite_screen/favorite_screen.dart';
import 'package:shop_app_1/moduls/shop_app/product_screen/product_screen.dart';
import 'package:shop_app_1/moduls/shop_app/setting_scrren/setting_screen.dart';
import 'package:shop_app_1/shared/components/constants.dart';
import 'package:shop_app_1/shared/network/remote/dio_helper.dart';
import 'package:shop_app_1/shared/network/remote/end_points.dart';

import '../../../models/shop_app/categories_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    ProductScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  void changeBottomScreen(int index) {
    currentIndex = index;
    emit(ShopChangeButtonNavState());
  }

  HomeModel? homeModel;
  Map<int, bool>? favorite = {};

  void getHomeData() {
    emit(ShopGetLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value!.data);
      homeModel!.data.products.forEach((element) {
        favorite!.addAll({element.id: element.inFavorites});
      });
      // print(favorite.toString());
      emit(ShopGetSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value!.data);

      emit(ShopGetSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetErrorCategoriesDataState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorite![productId] = !favorite![productId]!;
    emit(ShopGetChangeFavoritesDataState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': productId},
      token: token!,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value!.data);
      if (!changeFavoritesModel!.status) {
        favorite![productId] = !favorite![productId]!;
      } else {
        getFavData();
      }
      // print(value.data.toString());
      emit(ShopGetSuccessChangeFavoritesDataState());
    }).catchError((error) {
      if (!changeFavoritesModel!.status) {
        favorite![productId] = !favorite![productId]!;
      }
      print(error.toString());
      emit(ShopGetErrorChangeFavoritesDataState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavData() {
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value!.data);
      // print(value.data.toString());
      emit(ShopGetSuccessFavDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetErrorFavDataState());
    });
  }

  ShopLoginModel? shopLoginModel;

  void getUserData() {
    DioHelper.getData(
      url: PROVILE,
      token: token,
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value!.data);
      print(shopLoginModel!.data!.name);
      emit(ShopGetSuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetErrorUserDataState());
    });
  }

  void updateUserData(
    String name,
    String email,
    String phone,
  ) {
    emit(ShopGetLoadingUpdateUserDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token!,
      data: {
        "name": name,
        "phone": phone,
        "email": email,
      },
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromJson(value!.data);
      print(shopLoginModel!.data!.name);
      emit(ShopGetSuccessUpdateUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetErrorUpdateUserDataState());
    });
  }
}
