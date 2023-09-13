import 'package:shop_app_1/models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginChangeVisibilityPasswordState extends ShopLoginStates {}
