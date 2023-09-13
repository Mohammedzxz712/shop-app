import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/shop_layout_screen.dart';
import 'package:shop_app_1/moduls/shop_app/cubit/cubit.dart';
import 'package:shop_app_1/moduls/shop_app/cubit/states.dart';
import 'package:shop_app_1/moduls/shop_app/shop_register_screen/shop_register_screen.dart';
import 'package:shop_app_1/shared/components/components.dart';
import 'package:shop_app_1/shared/components/constants.dart';

import '../../../shared/network/local/cash_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.status);
              print(state.loginModel.message);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Login now to browse our hot offers.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email must required';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email address',
                              prefixIcon: Icon(Icons.email)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.ge(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          controller: passwordController,
                          obscureText: ShopLoginCubit.ge(context).obscureText,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password must required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: InkWell(
                                onTap: () {
                                  ShopLoginCubit.ge(context)
                                      .changeVisiblePassword();
                                },
                                child:
                                    Icon(ShopLoginCubit.ge(context).visible)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.ge(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            color: Colors.orange,
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              child: const Center(
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'don\'n have an account?',
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigatorTo(context, ShopRegisterScreen());
                                  },
                                  child: const Text('Register Now'))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
// Fluttertoast.showToast(
//     msg: state.loginModel.message,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: Colors.green,
//     textColor: Colors.white,
//     fontSize: 16.0);
// Fluttertoast.showToast(
//     msg: state.loginModel.message,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: Colors.red,
//     textColor: Colors.white,
//     fontSize: 16.0);
