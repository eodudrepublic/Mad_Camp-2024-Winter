import 'package:flutter/material.dart';
import 'package:kaist_delivery/view/tab1/widget/restaurant_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../controller/tab1/restaurant_controller.dart';

class RestaurantView extends StatelessWidget {
  RestaurantView({super.key});

  // HomeBinding에서 Get.lazyPut으로 초기화한 RestaurantController를 사용
  final RestaurantController controller = Get.find();

  //call 기능
  Future<void> _call(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    //print(launchUri);           //전화번호 맞는지 확인
    if (!await launchUrl(launchUri)) {
      throw '전화번호가 없습니다.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.restaurantList.isEmpty) {
          return const Center(child: Text('레스토랑이 없습니다.'));
        }

        return ListView.builder(
          itemCount: controller.restaurantList.length,
          itemBuilder: (context, index) {
            final restaurant = controller.restaurantList[index];
            return RestaurantCard(
              restaurant: restaurant,
              onCall: _call,
            );
          },
        );
      }),
    );
  }
}
