import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/tab1/restaurant_controller.dart';

class RestaurantListView extends StatelessWidget {
  RestaurantListView({Key? key}) : super(key: key);

  // GetX를 사용하여 컨트롤러 초기화
  final RestaurantController controller = Get.put(RestaurantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('레스토랑 목록'),
      ),
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
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: Icon(Icons.restaurant, color: Colors.blue),
                title: Text(
                  restaurant.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 16, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(restaurant.phone),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: Colors.grey),
                        SizedBox(width: 5),
                        Text(
                            '${restaurant.openTime} - ${restaurant.closeTime}'),
                      ],
                    ),
                  ],
                ),
                // trailing: Text(restaurant.phone), // 기존 전화번호 표시 제거
              ),
            );
          },
        );
      }),
    );
  }
}
