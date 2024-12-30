import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kaist_delivery/common/app_colors.dart';

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
            offset: const Offset(0, -4),
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
              height: (iconHeight * (6/7)).sp,
              width: (iconWidth * (6/7)).sp,
            ),
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
            label: "맛집 소개",
          ),
          _buildIconButton(
            icon: SvgPicture.asset(
              currentIndex == 1
                  ? 'assets/svg/home_on.svg'
                  : 'assets/svg/home_off.svg',
              height: (iconHeight * (6/7)).sp,
              width: (iconWidth * (6/7)).sp,
            ),
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
            label: "홈",
          ),
          _buildIconButton(
            icon: SvgPicture.asset(
              currentIndex == 2
                  ? 'assets/svg/menu_on.svg'
                  : 'assets/svg/menu_off.svg',
              height: (iconHeight * (6/7)).sp,
              width: (iconWidth * (6/7)).sp,
            ),
            isSelected: currentIndex == 2,
            onTap: () => onTap(2),
            label: "나의 목록",
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon, // 아이콘
          const SizedBox(
            height: 3,
          ),
          if (label != null) // 라벨이 있을 경우 항상 표시
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: isSelected
                    ? AppColors.mainThemeDarkColor // 선택된 경우 진한 노랑색
                    : Colors.black, // 선택되지 않은 경우 검은색
              ),
            ),
        ],
      ),
    );
  }
}
