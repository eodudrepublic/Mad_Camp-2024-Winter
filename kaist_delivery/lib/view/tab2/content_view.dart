import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaist_delivery/common/app_colors.dart';
import 'package:kaist_delivery/common/widget/custom_appbar.dart';
import '../../controller/tab2/content_controller.dart';
import '../../model/content.dart';


class ContentView extends StatelessWidget {
  ContentView({super.key});

  final ContentController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: '맛집 소개',
        rightIconWidget: const Icon(Icons.search, color: Colors.black, size: 33),
        onRightIconTap: () {
          Get.toNamed('/search');
        },
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
        onDoubleTap: controller.resetOrder, // 더블 클릭 이벤트
        child: Obx(
              () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : controller.contentList.isEmpty
              ? const Center(child: Text('추천 메뉴가 없습니다.'))
              : Column(
            children: [
              SizedBox(height: 0.05.sh),
              _buildHeader(),
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemBuilder: (context, index) {
                    final actualIndex = index % controller.contentList.length;
                    final content = controller.contentList[actualIndex];
                    return _contentCard(content, actualIndex);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          controller.getFormattedDate(),
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          controller.getHeaderText(),
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _contentCard(Content content, int index) {
    bool isFirst = index == (controller.initialPage % controller.contentList.length);

    return Padding(
      padding: EdgeInsets.only(
        left: 8.sp,
        right: 8.sp,
        top: 30.sp,
        bottom: 40.sp,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
          border: isFirst
              ? Border.all(
            color: AppColors.mainThemeDarkColor, // 첫 번째 맛집만 노란색 테두리
            width: 2.sp,
          )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.asset(
                    'assets/image/${content.name}.jpg',
                    width: double.infinity,
                    height: 0.35.sh,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20.sp),
              Text(
                content.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.sp),
              Text(
                content.content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
