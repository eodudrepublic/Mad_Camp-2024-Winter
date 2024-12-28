import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/app_colors.dart';
import '../../controller/tab3/search_controller.dart';
import '../tab1/widget/restaurant_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// class SearchView extends StatelessWidget {
//   SearchView({super.key});
//
//   final RestaurantSearchController controller =
//   Get.put(RestaurantSearchController());
//   final TextEditingController searchController = TextEditingController();

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final RestaurantSearchController controller =
  Get.put(RestaurantSearchController());
  late TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(); // 검색 컨트롤러 초기화
  }

  @override
  void dispose() {
    searchController.dispose(); // 검색 컨트롤러 메모리 정리
    controller.clearSearchResults(); // 검색 결과 초기화
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // 검색창
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 25.sp),
            decoration: BoxDecoration(
              color: AppColors.searchBackgroundColor,
              border: Border.all(
                color: AppColors.searchIconColor,
                width: 1.5.sp,
              ),
              borderRadius: BorderRadius.circular(22.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
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
                        horizontal: 20.sp,
                      ),
                    ),
                    cursorColor: AppColors.searchIconColor,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    onSubmitted: (value) {
                      controller.searchRestaurants(value); // 키보드 완료 버튼 눌렀을 때 검색
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: AppColors.searchIconColor,
                    size: 40.sp,
                  ),
                  onPressed: () {
                    controller.searchRestaurants(searchController.text);
                  },
                ),
              ],
            ),
          ),
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
}
