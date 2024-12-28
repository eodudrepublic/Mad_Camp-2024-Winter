import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final int iconHeight;
  final int iconWidth;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.iconHeight = 32,
    this.iconWidth = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.sp, // 바 높이 조정
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, -4),
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 아이콘 간격 균등 분배
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildIconButton(
            icon: SvgPicture.asset(
              currentIndex == 0
                  ? 'assets/svg/food_on.svg'
                  : 'assets/svg/food_off.svg',
              height: (iconHeight * (4 / 4)).sp,
              width: (iconWidth * (4 / 4)).sp,
            ),
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
            label: "메뉴 추천",
          ),
          _buildIconButton(
            icon: SvgPicture.asset(
              currentIndex == 1
                  ? 'assets/svg/menu_on.svg'
                  : 'assets/svg/menu_off.svg',
              height: (iconHeight * (4 / 5)).sp,
              width: (iconWidth * (4 / 5)).sp,
            ),
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
            label: "가게 목록",
          ),
          _buildIconButton(
            icon: SvgPicture.asset(
              currentIndex == 2
                  ? 'assets/svg/search_on.svg'
                  : 'assets/svg/search_off.svg',
              height: (iconHeight * (8 / 9)).sp,
              width: (iconWidth * (8 / 9)).sp,
            ),
            isSelected: currentIndex == 2,
            onTap: () => onTap(2),
            label: "검색",
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required Widget icon,
    required bool isSelected,
    required VoidCallback onTap,
    String? label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon, // 아이콘
          SizedBox(height: 3,),
          if (isSelected && label != null) // 선택된 경우 라벨 표시
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black, // 라벨 색상
              ),
            ),
        ],
      ),
    );
  }
}

