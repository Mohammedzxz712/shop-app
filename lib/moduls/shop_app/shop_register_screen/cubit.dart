import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/moduls/shop_app/shop_register_screen/states.dart';

import '../../../models/shop_app/login_model.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/remote/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit ge(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      // lang: 'en',
      data: {
        'email': email,
        'password': password,
        'phone': phone,
        'name': name,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value?.data);
      // print(loginModel.data?.token);
      // print(loginModel.message);
      // print(loginModel.status);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(
        ShopRegisterErrorState(
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
    emit(ShopRegisterChangeVisibilityPasswordState());
  }
}
