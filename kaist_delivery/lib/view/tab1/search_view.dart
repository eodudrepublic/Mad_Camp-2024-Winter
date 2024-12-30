import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaist_delivery/common/widget/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/app_colors.dart';
import '../../controller/tab1/restaurant_controller.dart';
import 'widget/restaurant_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  // HomeBinding에서 Get.lazyPut으로 초기화한 RestaurantSearchController를 사용
  final RestaurantController controller = Get.find();
  late TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(); // 검색 컨트롤러 초기화
  }

  @override
  void dispose() {
    controller.clearSearchResults(); // 검색 결과 초기화
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO : 화면 틀 좌우 여백 20.sp로 통일 필요
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leftIconPath: 'assets/icon/back_icon.png',
        onLeftIconTap: () {
          // TODO : Get.back();
        },
        centerWidget: buildSearchBar(),
      ),
      body: Column(
        children: [
          // 검색 결과 리스트
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.filteredList.isEmpty) {
                return const Center(child: Text('검색 결과가 없습니다.'));
              }

              return ListView.builder(
                itemCount: controller.filteredList.length,
                itemBuilder: (context, index) {
                  final restaurant = controller.filteredList[index];
                  return RestaurantCard(
                    restaurant: restaurant,
                    onCall: (phoneNumber) {
                      final Uri launchUri = Uri(
                        scheme: 'tel',
                        path: phoneNumber,
                      );
                      try {
                        launchUrl(launchUri);
                      } catch (e) {
                        Get.snackbar('오류', '전화 연결 실패: $e');
                      }
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // TODO : 검색 페이지에 쓰일 검색바 위젯 -> AppBar에 들어감
  Widget buildSearchBar() {
    return Container(
      height: 40.sp,
      decoration: BoxDecoration(
        color: AppColors.searchBackgroundColor,
        border: Border.all(
          color: AppColors.searchIconColor,
          width: 1.sp,
        ),
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0.25,
            blurRadius: 2.5,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.transparent,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 15.sp,
                ),
                hintText: '검색어를 입력해주세요',
              ),
              cursorColor: AppColors.searchIconColor,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
              onSubmitted: (value) {
                controller.searchRestaurants(value); // 키보드 완료 버튼 눌렀을 때 검색
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.sp),
            child: GestureDetector(
              onTap: () {
                // 검색 버튼 누를 때
                controller.searchRestaurants(searchController.text);
              },
              child: Icon(
                Icons.search,
                color: AppColors.searchIconColor,
                size: 30.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
