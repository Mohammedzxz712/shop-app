import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/moduls/shop_app/cubit/states.dart';

import '../../../models/shop_app/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit ge(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value?.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(
        ShopLoginErrorState(
          error.toString(),
        ),
      );
    });
  }

  IconData visible = Icons.visibility_outlined;
  bool obscureText = true;

  void changeVisiblePassword() {
    obscureText = !obscureText;
    obscureText
        ? visible = Icons.visibility_outlined
        : visible = Icons.visibility_off_outlined;
    emit(ShopLoginChangeVisibilityPasswordState());
  }
}
