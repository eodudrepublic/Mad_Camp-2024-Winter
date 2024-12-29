import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantCard extends StatelessWidget {
  final dynamic restaurant;
  final Function(String) onCall;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white, // 배경색
        borderRadius: BorderRadius.circular(5), // 둥근 모서리
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 그림자 색상
            blurRadius: 4, // 그림자 흐림 정도
            offset: const Offset(0, 4), // 그림자 위치 (x, y)
          ),
        ],
      ),
      child: ListTile(
        tileColor: Colors.white,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Container(
            width: 0.2.sw,
            height: 0.2.sw,
            child: Image.asset(
              'assets/image/${restaurant.name}.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          restaurant.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0.01.sh),
                Row(
                  children: [
                    Icon(Icons.phone, size: 16.sp, color: Colors.grey),
                    SizedBox(width: 5.w),
                    Text(
                      restaurant.phone,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
                SizedBox(height: 0.01.sh),
                // TODO : 영업시간이 아니면 흐려지게 / 아니면 아래에 위치하는 기능 추가
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16.sp, color: Colors.grey),
                    Text(
                      '${restaurant.openTime} - ${restaurant.closeTime}',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                onCall(restaurant.phone);
              },
              child: Text(
                '전화연결',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
