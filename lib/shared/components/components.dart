import 'package:flutter/material.dart';

import '../../layout/shop_layout/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  double radius = 0,
  bool isUpper = true,
  required String text,
  required Function()? function,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function!(),
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultFormFailed({
  required TextEditingController controller,
  required TextInputType type,
  final Function? onSubmit,
  final Function? onChange,
  final Function? validate,
  final Function? onTap,
  final bool ispassword = false,
  required String label,
  required IconData prefix,
  IconData? suffix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: ispassword,
      onFieldSubmitted: onSubmit!(),
      onChanged: onChange!(),
      onTap: onTap!(),
      validator: validate!(),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null ? Icon(suffix) : null,
      ),
    );

Widget myDivider() => Container(
      height: 1,
      color: Colors.grey[300],
      width: double.infinity,
    );

void navigatorTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
      //(Route<dynamic> route) => false,
    );

Widget buildProductItem(model, context, {bool isDiscount = true}) => Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                // fit: BoxFit.cover,
                width: 120,
              ),
              if (model.discount != 0 && isDiscount == true)
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
                )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price} EL',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      if (model.oldPrice != 0 && isDiscount == true)
                        Text(
                          '${model.oldPrice}',
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
                          ShopCubit.get(context)
                              .changeFavorites((model.product?.id)!);
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
          ),
        ],
      ),
    );
