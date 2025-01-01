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
  final RestaurantController controller = Get.find();
  late final TextEditingController searchController = TextEditingController();
  //검색어 페이지에서 키보드 자동 활성화
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _focusNode.dispose(); // FocusNode 메모리 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leftIconWidget: const Icon(Icons.arrow_back, color: Colors.black, size: 31,),
        onLeftIconTap: () {
          controller.clearSearchResults(); // 검색 결과 초기화
          Get.back();
        },
        centerWidget: buildSearchBar(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.searchList.isEmpty) {
                return const Center(child: Text('검색 결과가 없습니다.'));
              }
              return ListView.builder(
                itemCount: controller.searchList.length,
                itemBuilder: (context, index) {
                  final restaurant = controller.searchList[index];
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
                    onMap: (name) {
                      final Uri launchUri = Uri.parse(
                        'nmap://search?query=$name&appname=immersion_camp.week1.app.kaist_delivery',
                      );
                      try {
                        launchUrl(launchUri);
                      } catch (e) {
                        Get.snackbar('오류', '지도 연결 실패: $e');
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
              focusNode: _focusNode, // FocusNode를 연결
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
                controller.searchRestaurants(value);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.sp),
            child: GestureDetector(
              onTap: () {
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
