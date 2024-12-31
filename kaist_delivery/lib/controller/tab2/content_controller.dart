import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../model/content.dart';

class ContentController extends GetxController {
  // Content 리스트를 저장하는 옵저버블 리스트
  var contentList = <Content>[].obs;
  // 더블 클릭 트리거
  var doubleTapTrigger = false.obs;
  // 로딩 상태를 나타내는 변수
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadContents();
  }

  // JSON에서 Content 데이터를 로드하는 메서드
  Future<void> loadContents() async {
    try {
      isLoading(true);
      final String jsonString =
      await rootBundle.loadString('assets/data/content_data.json');
      final List<dynamic> jsonResponse = json.decode(jsonString);
      var loadedContents =
      jsonResponse.map((json) => Content.fromJson(json)).toList();

      final int seed = _generateSeedForToday();
      loadedContents.shuffle(Random(seed));
      contentList.assignAll(loadedContents);
    } catch (e) {
      Get.snackbar('에러', '컨텐츠 데이터를 불러오지 못했습니다.');
    } finally {
      isLoading(false);
    }
  }

  // 일별로 카드 정렬하기 위해서
  int _generateSeedForToday() {
    final now = DateTime.now();
    return int.parse("${now.year}${now.month}${now.day}");
  }

  /// 맛집 소개 아이콘을 더블 클릭하면 스와이프 했던 순서가 초기화 되어 처음으로 돌아가도록.
  void resetOrder() {
    doubleTapTrigger.value = true; // 더블 클릭 트리거 활성화
    loadContents(); // 순서 초기화
    Future.delayed(Duration(milliseconds: 100), () {
      doubleTapTrigger.value = false; // 트리거 초기화
    });
  }
}
