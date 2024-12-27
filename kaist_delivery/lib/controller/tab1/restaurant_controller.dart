import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../model/restaurant.dart';

class RestaurantController extends GetxController {
  // 레스토랑 목록을 저장하는 옵저버블 리스트
  var restaurantList = <Restaurant>[].obs;

  // 로딩 상태를 나타내는 변수
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadRestaurants();
  }

  // JSON에서 레스토랑 데이터를 로드하는 메서드
  Future<void> loadRestaurants() async {
    try {
      isLoading(true);
      // assets에서 JSON 문자열 로드
      final String jsonString =
          await rootBundle.loadString('assets/data/data.json');
      // JSON 데이터 디코드
      final List<dynamic> jsonResponse = json.decode(jsonString);
      // JSON을 Restaurant 모델로 매핑
      var loadedRestaurants =
          jsonResponse.map((json) => Restaurant.fromJson(json)).toList();
      // 옵저버블 리스트 업데이트
      restaurantList.assignAll(loadedRestaurants);
    } catch (e) {
      Get.snackbar('에러', '레스토랑 데이터를 불러오지 못했습니다.');
    } finally {
      isLoading(false);
    }
  }
}
