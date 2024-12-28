import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controller/tab2/content_controller.dart';

class ContentView extends StatelessWidget {
  ContentView({super.key});

  // GetX를 사용하여 컨트롤러 초기화
  final ContentController controller = Get.put(ContentController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isLoading.value
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
                    return _contentCard(context, content);
                  },
                ),
              ));
  }

  // _contentCard 위젯 분리
  Widget _contentCard(BuildContext context, dynamic content) {
    // TODO : Card 상단에 시간 표시 (앱 시작 시간 날짜 기준)
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 20.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
}
