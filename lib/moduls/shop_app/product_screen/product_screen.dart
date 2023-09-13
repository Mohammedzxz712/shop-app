import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_1/models/shop_app/categories_model.dart';
import 'package:shop_app_1/models/shop_app/home_model.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: (ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null),
          builder: (context) => builderHome(ShopCubit.get(context).homeModel!,
              ShopCubit.get(context).categoriesModel!, context),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget builderHome(HomeModel model, CategoriesModel categoriesModel, context) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(e.image),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayInterval: const Duration(seconds: 3),
              height: 200,
              enableInfiniteScroll: true,
              initialPage: 0,
              reverse: false,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    height: 90,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoriesItem(
                            categoriesModel.data!.data[index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 5,
                            ),
                        itemCount: categoriesModel.data!.data.length)),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'New product',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.74,
              crossAxisSpacing: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data.products.length,
                (index) => buildGridView(model.data.products[index], context),
              ),
            ),
          )
        ],
      ),
    );

Widget buildGridView(ProductsData model, context) => Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                // fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              if (model.discount != 0)
                Container(
                  padding: EdgeInsets.all(3),
                  color: Colors.orange,
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()} LE',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    if (model.oldPrice != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor:
                            ShopCubit.get(context).favorite![model.id]!
                                ? Colors.orange
                                : Colors.grey[350],
                        child: const Icon(
                          Icons.favorite_border,
                          size: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

Widget buildCategoriesItem(DataModel model) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(
            '${model.image}',
          ),
          fit: BoxFit.cover,
          height: 90,
          width: 90,
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(.7),
          child: Text(
            '${model.name}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
