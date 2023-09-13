import 'package:shop_app_1/moduls/shop_app/login/shop_login_screen.dart';
import 'package:shop_app_1/shared/components/components.dart';
import 'package:shop_app_1/shared/network/local/cash_helper.dart';

String? token;

void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then(
    (value) {
      if (value == true) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    },
  );
}
