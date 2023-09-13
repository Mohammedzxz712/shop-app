import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/moduls/shop_app/search_screen/cubit/cubit.dart';
import 'package:shop_app_1/moduls/shop_app/search_screen/cubit/states.dart';

import '../../../shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'search is required';
                          }
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            SearchCubit.get(context)
                                .searchData(searchController.text);
                          }
                        },
                        controller: searchController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          labelText: 'search',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (state is SearchLoadingStates)
                        const LinearProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      if (SearchCubit.get(context).searchModel != null)
                        Expanded(
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => buildProductItem(
                                  isDiscount: false,
                                  SearchCubit.get(context)
                                      .searchModel!
                                      .data!
                                      .data![index],
                                  context),
                              separatorBuilder: (context, index) => myDivider(),
                              itemCount: SearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .data!
                                  .length),
                        ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
