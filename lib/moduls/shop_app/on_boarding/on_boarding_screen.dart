import 'package:flutter/material.dart';
import 'package:shop_app_1/shared/components/components.dart';
import 'package:shop_app_1/shared/network/local/cash_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../generated/assets.dart';
import '../login/shop_login_screen.dart';

class BoardingModel {
  final String title;
  final String image;
  final String body;

  BoardingModel({required this.title, required this.body, required this.image});
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boardingModel = [
    BoardingModel(
      image: Assets.imagesShop1,
      body: 'onboard 1 body',
      title: 'onboard 1 body',
    ),
    BoardingModel(
      image: Assets.imagesShop1,
      body: 'onboard 2 body',
      title: 'onboard 2 body',
    ),
    BoardingModel(
      image: Assets.imagesShop1,
      body: 'onboard 3 body',
      title: 'onboard 3 body',
    ),
  ];

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: const Text('SKIP'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boardingModel[index]),
                itemCount: 3,
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boardingModel.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boardingModel.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.orange,
                    dotColor: Colors.grey,
                    dotHeight: 5,
                    dotWidth: 10,
                    expansionFactor: 3,
                    spacing: 5,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastEaseInToSlowEaseOut);
                    }
                  },
                  child:
                      const Icon(Icons.arrow_forward_ios, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              model.image,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          model.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          model.body,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
