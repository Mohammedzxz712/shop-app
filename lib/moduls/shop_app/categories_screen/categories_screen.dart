import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_1/models/shop_app/categories_model.dart';
import 'package:shop_app_1/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data!.data.length);
      },
    );
  }
}

Widget buildCatItem(DataModel model) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            '${model.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
