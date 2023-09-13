import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/cubit.dart';
import 'package:shop_app_1/layout/shop_layout/cubit/states.dart';
import 'package:shop_app_1/shared/components/components.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state != ShopGetLoadingFavDataState(),
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildProductItem(
                ShopCubit.get(context)
                    .favoritesModel!
                    .data!
                    .data![index]
                    .product,
                context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount:
                ShopCubit.get(context).favoritesModel!.data!.data!.length,
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

// Widget buildFavItem(DataFav model, context) => Container(
//       height: 120,
//       child: Row(
//         children: [
//           Stack(
//             alignment: AlignmentDirectional.bottomStart,
//             children: [
//               Image(
//                 image: NetworkImage('${model.product!.image}'),
//                 // fit: BoxFit.cover,
//                 width: 120,
//               ),
//               if (model.product!.discount != 0)
//                 Container(
//                   padding: EdgeInsets.all(3),
//                   color: Colors.orange,
//                   child: const Text(
//                     'DISCOUNT',
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: Colors.white,
//                     ),
//                   ),
//                 )
//             ],
//           ),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '${model.product!.name}',
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       height: 1.3,
//                     ),
//                   ),
//                   Spacer(),
//                   Row(
//                     children: [
//                       Text(
//                         '${model.product!.price} EL',
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           color: Colors.orange,
//                           fontSize: 12,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 7,
//                       ),
//                       if (model.product!.oldPrice != 0)
//                         Text(
//                           '${model.product!.oldPrice}',
//                           overflow: TextOverflow.ellipsis,
//                           style: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 11,
//                             decoration: TextDecoration.lineThrough,
//                           ),
//                         ),
//                       const Spacer(),
//                       IconButton(
//                         onPressed: () {
//                           ShopCubit.get(context)
//                               .changeFavorites((model.product?.id)!);
//                         },
//                         icon: CircleAvatar(
//                           backgroundColor: ShopCubit.get(context)
//                                   .favorite[model.product!.id]!
//                               ? Colors.orange
//                               : Colors.grey[350],
//                           child: const Icon(
//                             Icons.favorite_border,
//                             size: 17,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
