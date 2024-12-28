import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../model/content.dart';

class ContentController extends GetxController {
  // Content 리스트를 저장하는 옵저버블 리스트
  var contentList = <Content>[].obs;

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
      // assets에서 JSON 문자열 로드
      final String jsonString =
          await rootBundle.loadString('assets/data/content_data.json');
      // JSON 데이터 디코드
      final List<dynamic> jsonResponse = json.decode(jsonString);
      // JSON을 Content 모델로 매핑
      var loadedContents =
          jsonResponse.map((json) => Content.fromJson(json)).toList();
      // 옵저버블 리스트 업데이트
      contentList.assignAll(loadedContents);
      // TODO : 이거 랜덤으로 바꾸면 좋지 않을까?
    } catch (e) {
      Get.snackbar('에러', '컨텐츠 데이터를 불러오지 못했습니다.');
    } finally {
      isLoading(false);
    }
  }
}
