import 'dart:convert';
import 'package:flutter/material.dart'; // PageController, ScrollController, Curves
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/util/logger.dart';
import '../../model/restaurant.dart';

class RestaurantController extends GetxController {
  /// 원본 레스토랑 목록 (로딩 후 전체 데이터)
  var restaurantList = <Restaurant>[].obs;

  /// 메인 화면에 표시할 필터/정렬 결과
  var filteredListMain = <Restaurant>[].obs;

  /// 검색 화면에서 표시할 필터(검색) 결과
  var searchList = <Restaurant>[].obs;

  /// 로딩 상태
  var isLoading = true.obs;

  /// 카테고리 관련
  var selectedCategoryIndex = 0.obs;
  final List<String> categories = [
    '전체',
    '한식',
    '중식',
    '분식',
    '일식',
    '야식',
    '아시안',
  ];

  /// 페이지 관련
  late PageController pageController;
  late ScrollController scrollController;

  @override
  Future<void> onInit() async {
    super.onInit();
    pageController = PageController();
    scrollController = ScrollController();

    /// 레스토랑 로드를 먼저 기다린 뒤, 정렬 & 카테고리 필터 → 메인 화면용 filteredListMain 구성
    await loadRestaurants();
    sortRestaurants(); // restaurantList 정렬
    filterRestaurantsByCategory(); // → filteredListMain에 카테고리 반영

    /// 검색 화면용 리스트는 처음엔 "전체"가 기본값
    searchList.clear();
  }

  // JSON에서 레스토랑 데이터를 로드하는 메서드
  Future<void> loadRestaurants() async {
    Log.info('레스토랑 데이터 로드 시작');
    try {
      isLoading(true);
      final String jsonString =
          await rootBundle.loadString('assets/data/data.json');
      final List<dynamic> jsonResponse = json.decode(jsonString);
      var loadedRestaurants =
          jsonResponse.map((json) => Restaurant.fromJson(json)).toList();

      restaurantList.assignAll(loadedRestaurants);
      // 메인/검색용 리스트는 load가 끝난 뒤 별도 함수에서 세팅
    } catch (e) {
      Get.snackbar('에러', '레스토랑 데이터를 불러오지 못했습니다.');
    } finally {
      Log.info('레스토랑 데이터 로드 완료');
      isLoading(false);
    }
  }

  // 영업 상태 확인 및 정렬 (메인화면 기준)
  void sortRestaurants() {
    DateTime now = DateTime.now();
    List<Restaurant> sortedList = List.from(restaurantList);

    Log.info('레스토랑 정렬 시작');
    sortedList.sort((a, b) {
      // A 식당의 운영 시간
      DateTime openA = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(a.openTime.split(':')[0]),
        int.parse(a.openTime.split(':')[1]),
      );
      DateTime closeA = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(a.closeTime.split(':')[0]),
        int.parse(a.closeTime.split(':')[1]),
      );
      // 새벽까지 운영하는 경우 고려
      if (closeA.isBefore(openA)) closeA = closeA.add(const Duration(days: 1));
      bool isOpenA = now.isAfter(openA) && now.isBefore(closeA);

      // B 식당의 운영 시간
      DateTime openB = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(b.openTime.split(':')[0]),
        int.parse(b.openTime.split(':')[1]),
      );
      DateTime closeB = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(b.closeTime.split(':')[0]),
        int.parse(b.closeTime.split(':')[1]),
      );
      if (closeB.isBefore(openB)) closeB = closeB.add(const Duration(days: 1));
      bool isOpenB = now.isAfter(openB) && now.isBefore(closeB);

      // 정렬 기준: 영업중인 식당을 먼저 배치
      if (isOpenA && !isOpenB) return -1;
      if (!isOpenA && isOpenB) return 1;
      return 0;
    });

    // 정렬 결과를 restaurantList에 반영
    restaurantList.assignAll(sortedList);
    Log.info('레스토랑 정렬 완료');
  }

  // 카테고리 필터링 (메인화면 기준)
  void filterRestaurantsByCategory() {
    final category = categories[selectedCategoryIndex.value];
    Log.info('카테고리 필터링 시작: $category');

    if (selectedCategoryIndex.value == 0) {
      // '전체'라면 restaurantList 그대로
      filteredListMain.assignAll(restaurantList);
    } else {
      filteredListMain.assignAll(
        restaurantList.where((r) => r.category == category).toList(),
      );
    }
    Log.info('카테고리 필터링 완료');
  }

  // 메인 화면에서 카테고리 변경 시
  void changeCategory(int index) {
    Log.info('카테고리 변경: $index');
    selectedCategoryIndex.value = index;
    pageController.jumpToPage(index);

    // 스크롤 애니메이션
    double scrollPosition = index * 100.0;
    if (index >= 3) {
      scrollPosition = (index - 2) * 100.0;
    } else {
      scrollPosition = 0;
    }
    scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    // 변경된 카테고리에 맞춰 다시 정렬 & 필터 적용
    sortRestaurants();
    filterRestaurantsByCategory();
  }

  // ──────────────────────────────
  //  ─── 검색 기능 전용 로직 ───
  // ──────────────────────────────
  /// 검색 기능 (search 화면에서 사용)
  void searchRestaurants(String query) {
    if (query.isEmpty) {
      // 검색어 없으면 전체 표시
      //searchList.assignAll(restaurantList);
      searchList.clear();
    } else {
      searchList.assignAll(
        restaurantList.where(
          (r) => r.name.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  /// 검색 결과 초기화 (search 화면에서 뒤로가기 시 전체 복원 등)
  void clearSearchResults() {
    //searchList.assignAll(restaurantList);
    searchList.clear();
  }

  // 전화 걸기 기능
  Future<void> call(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(launchUri)) {
      throw '전화번호가 없습니다.';
    }
  }

  // 네이버 지도 연결 기능
  Future<void> navermap(String name) async {
    final Uri launchUri = Uri.parse(
      'nmap://search?query=$name&appname=immersion_camp.week1.app.kaist_delivery',
    );
    if (!await launchUrl(launchUri)) {
      throw '장소가 없습니다.';
    }
  }
}
