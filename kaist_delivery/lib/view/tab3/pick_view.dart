import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaist_delivery/common/widget/custom_appbar.dart';
import '../../common/app_colors.dart';
import '../../controller/tab3/pick_controller.dart';

class PickView extends StatelessWidget {
  const PickView({super.key});

  @override
  Widget build(BuildContext context) {
    // HomeBinding에서 Get.lazyPut으로 초기화한 PickController를 사용
    final PickController controller = Get.find();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        titleText: '오늘의 Pick',
        rightIconPath: 'assets/icon/search_icon.png',
        onRightIconTap: () {
          // TODO : Get.toNamed('/search');
          // tab1, tab2, tab3에서 모두 search 페이지로 넘어가도록
        },
      ),
      body: Obx(() {
        // 추천된 메뉴(selectedPick)가 비어있는지 여부 판단
        final hasPick = controller.selectedPick.value.isNotEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// -- 조건부로 보여줄 컨테이너 --
            hasPick
                ? _pickedContainer(controller) // Container 2
                : _guideContainer(controller), // Container 1

            // "나의 Pick" 헤더
            // TODO : 목록 DB에 데이터하는 기능 추가 필요
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
              alignment: Alignment.centerLeft,
              child: Text(
                '나의 Pick',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 리스트 영역
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: ListView.builder(
                  itemCount: controller.pickList.length,
                  itemBuilder: (context, index) {
                    final pick = controller.pickList[index];
                    final bool isFirst = index == 0;
                    final bool isLast = index == controller.pickList.length - 1;

                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.listBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft:
                              isFirst ? Radius.circular(10.r) : Radius.zero,
                          topRight:
                              isFirst ? Radius.circular(10.r) : Radius.zero,
                          bottomLeft:
                              isLast ? Radius.circular(10.r) : Radius.zero,
                          bottomRight:
                              isLast ? Radius.circular(10.r) : Radius.zero,
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 1.5.sp),
                      padding: EdgeInsets.all(12.sp),
                      child: Text(
                        pick.name,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  /// Container 1 : 아직 메뉴를 추천받지 않았을 때( selectedPick == "" )
  Widget _guideContainer(PickController controller) {
    return Container(
      alignment: Alignment.center,
      height: 0.25.sh,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.sp, color: AppColors.searchIconColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 상단 설명
          Text(
            '나의 Pick 리스트에서 랜덤으로\n오늘의 메뉴를 추천해드립니다:D',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 14.sp),

          // "메뉴 추천 받기" 버튼
          ElevatedButton(
            onPressed: () => controller.getRandomPick(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainThemeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: BorderSide(
                  color: Colors.black, // 테두리 색상
                  width: 1.sp, // 테두리 두께
                ),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 5.sp),
              child: Text(
                '랜덤 Pick 받기',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Container 2 : 메뉴가 추천된 이후( selectedPick != "" )
  Widget _pickedContainer(PickController controller) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 0.25.sh,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.sp, color: AppColors.searchIconColor),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 오늘의 Pick 표시
          Text(
            '오늘의 Pick은 ~??',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.sp),

          // 추천된 메뉴
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
            constraints: BoxConstraints(
              minWidth: 0.5.sw,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.sp,
              ),
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.mainThemeColor,
            ),
            child: Text(
              controller.selectedPick.value,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
