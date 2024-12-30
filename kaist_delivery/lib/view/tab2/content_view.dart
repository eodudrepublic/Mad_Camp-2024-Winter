import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaist_delivery/common/widget/custom_appbar.dart';
import '../../controller/tab2/content_controller.dart';

class ContentView extends StatelessWidget {
  ContentView({super.key});

  // HomeBinding에서 Get.lazyPut으로 초기화한 ContentController를 사용
  final ContentController controller = Get.find();

  // 요일을 한국어로 매핑한 리스트
  static const List<String> koreanWeekdays = [
    '월', // Monday
    '화', // Tuesday
    '수', // Wednesday
    '목', // Thursday
    '금', // Friday
    '토', // Saturday
    '일', // Sunday
  ];

  @override
  Widget build(BuildContext context) {
    // TODO : 화면 틀 좌우 여백 20.sp로 통일 필요
    return Scaffold(
      appBar: CustomAppBar(
        titleText: '맛집 소개',
        rightIconPath: 'assets/icon/search_icon.png',
        onRightIconTap: () {
          // TODO : Get.toNamed('/search');
          // tab1, tab2, tab3에서 모두 search 페이지로 넘어가도록
        },
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : controller.contentList.isEmpty
              ? const Center(child: Text('추천 메뉴가 없습니다.'))
              : Container(
                  constraints: const BoxConstraints.expand(),
                  padding: EdgeInsets.symmetric(horizontal: 0.1.sw),
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: controller.contentList.length,
                    itemBuilder: (context, index) {
                      final content = controller.contentList[index];
                      return _contentCard(context, content, index); // index 전달
                    },
                  ),
                )),
    );
  }

  /// _contentCard 위젯 : 음식점 소개 카드 위젯
  Widget _contentCard(BuildContext context, dynamic content, int index) {
    // index에 따라 날짜 계산
    DateTime cardDate = DateTime.now().subtract(Duration(days: index));
    String formattedDate = _formatDate(cardDate); // 날짜 포맷팅 함수 호출

    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 포맷된 날짜 표시
          Text(
            formattedDate,
            style: TextStyle(
              fontSize: 20.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.sp),
              borderRadius: BorderRadius.circular(8.0.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // 그림자 색상과 투명도
                  spreadRadius: 0.5, // 그림자 확산 정도
                  blurRadius: 5, // 그림자 흐림 정도
                  offset: const Offset(0, 5), // 그림자의 위치 (x: 오른쪽, y: 아래쪽)
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0.r),
              child: Image.asset(
                'assets/image/${content.name}.jpg',
                width: 0.8.sw,
                height: 0.8.sw,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 12.sp, bottom: 6.sp),
            child: Text(
              content.name,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            content.content,
            style: TextStyle(
              fontSize: 18.sp,
              // fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 날짜를 'yyyy/MM/dd (요일)' 형식으로 포맷팅하는 함수
  String _formatDate(DateTime date) {
    String year = date.year.toString();
    String month = date.month < 10 ? '0${date.month}' : date.month.toString();
    String day = date.day < 10 ? '0${date.day}' : date.day.toString();

    // 요일 가져오기 (1: 월요일, 7: 일요일)
    String weekday = koreanWeekdays[date.weekday - 1];

    // return '$year/$month/$day ($weekday)';
    return '$month/$day ($weekday)';
  }
}
