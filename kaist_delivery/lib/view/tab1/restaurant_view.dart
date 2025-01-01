import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common/app_colors.dart';
import '../../common/widget/custom_appbar.dart';
import '../../controller/tab1/restaurant_controller.dart';
import 'package:kaist_delivery/view/tab1/widget/restaurant_card.dart';

class RestaurantView extends StatefulWidget {
  const RestaurantView({super.key});

  @override
  _RestaurantViewState createState() => _RestaurantViewState();
}

class _RestaurantViewState extends State<RestaurantView> {
  // HomeBinding에서 Get.lazyPut으로 초기화한 RestaurantController를 사용
  final RestaurantController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        titleText: 'K-밥심',
        rightIconWidget: const Icon(Icons.search, color: Colors.black, size: 33,),
        onRightIconTap: () {
          Get.toNamed('/search');
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.restaurantList.isEmpty) {
          return const Center(child: Text('레스토랑이 없습니다.'));
        } else {
          return Column(
            children: [
              /// 상단 카테고리
              Container(
                margin: EdgeInsets.only(bottom: 5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: const Border(
                    bottom: BorderSide(
                      color: Colors.grey, // 경계선 색상
                      width: 1, // 경계선 두께
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child:
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal, // 수평 방향으로 스크롤되는 카테고리 버튼
                    controller: controller.scrollController,
                    child: Row(
                      children:
                      List.generate(controller.categories.length, (index) {
                        return _categoryButton(
                            controller.categories[index], index);
                      }),
                    ),
                  ),
                ),
              ),

              /// 전체 화면에서 스와이프 감지
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollUpdateNotification) {
                      int index = (controller.pageController.page ?? 0).round();
                      setState(() {
                        controller.selectedCategoryIndex.value = index;
                      });
                    }
                    return true;
                  },
                  child: PageView(
                    controller: controller.pageController,
                    onPageChanged: (index) {
                      controller.changeCategory(index);
                    },
                    children: controller.categories.map((category) {
                      return _categoryPage(category);
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  /// 카테고리 페이지
  Widget _categoryPage(String category) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      itemCount: controller.filteredListMain.length,
      itemBuilder: (context, index) {
        final restaurant = controller.filteredListMain[index];
        return RestaurantCard(
          restaurant: restaurant,
          onCall: controller.call,
          onMap: controller.navermap,
        );
      },
    );
  }

  /// 카테고리 버튼
  Widget _categoryButton(String category, int index) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w,),
      child: GestureDetector(
        onTap: () {
          controller.changeCategory(index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 10.h),
          decoration: BoxDecoration(
            border: controller.selectedCategoryIndex.value == index
                ? const Border(
                  bottom: BorderSide(
                    color: Colors.black, // 선택된 상태의 색상
                    width: 1.2, // 테두리 두께
                  ),
                )
                : null, // 선택되지 않았을 때는 테두리 없음
          ),
          child: Text(
            category,
            style: TextStyle(
              fontFamily: "Pretendard",
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: controller.selectedCategoryIndex.value == index
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
