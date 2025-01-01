import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/content.dart';

class ContentController extends GetxController {
  // Content 리스트를 저장하는 옵저버블 리스트
  var contentList = <Content>[].obs;

  // 로딩 상태를 나타내는 변수
  var isLoading = true.obs;

  // 현재 페이지를 관리하는 변수
  var currentPage = 0.obs;

  // PageController
  late PageController pageController;

  final int initialPage = 1000;

  @override
  void onInit() {
    super.onInit();
    loadContents();
    pageController = PageController(
      initialPage: initialPage,
      viewportFraction: 0.8,
    );
  }

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

  // 일별로 카드 정렬하기 위한 Seed 생성
  int _generateSeedForToday() {
    final now = DateTime.now();
    return int.parse("${now.year}${now.month}${now.day}");
  }

  /// 페이지 초기화 및 데이터 리셋
  Future<void> resetOrder() async {
    await loadContents();
    pageController.animateToPage(
      initialPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// 페이지 변경 시 호출
  void onPageChanged(int index) {
    currentPage.value = index % contentList.length;
  }

  /// 헤더 텍스트 반환
  String getHeaderText() {
    return "더 많은 맛집을 원하시면 좌우로 넘겨 주세요!";
  }

  /// 날짜 포맷팅
  String getFormattedDate() {
    DateTime date = DateTime.now();
    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    String day = date.day < 10 ? '0${date.day}' : '${date.day}';
    return '$month월 $day일의 맛집😋';
  }
}
