import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/states.dart';

import '../../../shared/components/constants.dart';

class SettingScreen extends StatelessWidget {
  var namController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).shopLoginModel;

        namController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: model!.data != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    if (state is ShopGetLoadingUpdateUserDataState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: namController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email must required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone must required';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'phone',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                              namController.text,
                              emailController.text,
                              phoneController.text,
                            );
                          }
                        },
                        child: const Text(
                          'UPDATE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          signOut(context);
                        },
                        child: const Text(
                          'LOGOUT',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
