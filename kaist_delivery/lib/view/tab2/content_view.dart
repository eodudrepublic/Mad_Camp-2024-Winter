import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaist_delivery/common/app_colors.dart';
import 'package:kaist_delivery/common/widget/custom_appbar.dart';
import '../../controller/tab2/content_controller.dart';

class ContentView extends StatefulWidget {
  ContentView({super.key});

  @override
  _ContentViewState createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  final ContentController controller = Get.find();
  late PageController _pageController;
  int currentPage = 0;
  int initialPage = 1000; // 초기 페이지 설정

  @override
  void initState() {
    super.initState();
    // 초기 페이지를 리스트 중간값으로 설정해 양쪽 스와이프 가능
    _pageController = PageController(
      initialPage: initialPage, // 중간값으로 설정
      viewportFraction: 0.8,
    );

    // 바텀 내비게이션 더블 클릭 가능하게
    controller.doubleTapTrigger.listen((isDoubleTap) {
      if (isDoubleTap) {
        _resetToInitialPage();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _resetToInitialPage() {
    controller.resetOrder(); // 컨트롤러에서 순서 초기화
    _pageController.animateToPage(
      1000, // 중간값으로 이동
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: '맛집 소개',
        rightIconPath: 'assets/icon/search_icon.png',
        onRightIconTap: () {
          Get.toNamed('/search');
        },
      ),
      backgroundColor: Colors.white,
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.contentList.isEmpty
            ? const Center(child: Text('추천 메뉴가 없습니다.'))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 0.05.sh),
            _buildHeader(),
            // 양 옆으로 스와이프 무한하게
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index % controller.contentList.length;
                  });
                },
                itemBuilder: (context, index) {
                  final actualIndex =
                      index % controller.contentList.length;
                  final content =
                  controller.contentList[actualIndex];
                  return _contentCard(context, content, actualIndex);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          _formatDate(DateTime.now()),
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          "더 많은 맛집을 원하시면 좌우로 넘겨 주세요!",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _contentCard(BuildContext context, dynamic content, int index) {
    // 오늘의 맛집 여부 확인
    bool isFirst = index ==
        (initialPage % controller.contentList.length);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.sp, horizontal: 8.sp),
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

  String _formatDate(DateTime date) {
    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    String day = date.day < 10 ? '0${date.day}' : '${date.day}';
    return '$month월 $day일의 맛집😋';
  }
}
