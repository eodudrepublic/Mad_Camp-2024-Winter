import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kaist_delivery/common/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Function(int)? onDoubleTap; // 더블 클릭 이벤트 추가
  final int iconHeight;
  final int iconWidth;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.onDoubleTap,
    this.iconHeight = 32,
    this.iconWidth = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.sp,
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildIconButton(
            index: 0,
            icon: SvgPicture.asset(
              currentIndex == 0
                  ? 'assets/svg/food_on.svg'
                  : 'assets/svg/food_off.svg',
              height: (iconHeight * (6 / 7)).sp,
              width: (iconWidth * (6 / 7)).sp,
            ),
            isSelected: currentIndex == 0,
            label: "맛집 소개",
          ),
          _buildIconButton(
            index: 1,
            icon: SvgPicture.asset(
              currentIndex == 1
                  ? 'assets/svg/home_on.svg'
                  : 'assets/svg/home_off.svg',
              height: (iconHeight * (6 / 7)).sp,
              width: (iconWidth * (6 / 7)).sp,
            ),
            isSelected: currentIndex == 1,
            label: "홈",
          ),
          _buildIconButton(
            index: 2,
            icon: SvgPicture.asset(
              currentIndex == 2
                  ? 'assets/svg/menu_on.svg'
                  : 'assets/svg/menu_off.svg',
              height: (iconHeight * (6 / 7)).sp,
              width: (iconWidth * (6 / 7)).sp,
            ),
            isSelected: currentIndex == 2,
            label: "나의 목록",
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required int index,
    required Widget icon,
    required bool isSelected,
    String? label,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      onDoubleTap: onDoubleTap != null ? () => onDoubleTap!(index) : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: 3),
          if (label != null)
            Text(
              label,
              style: TextStyle(
                fontFamily: "Titlefont",
                fontWeight: FontWeight.normal,
                fontSize: 10.sp,
                color: isSelected
                    ? AppColors.mainThemeDarkColor
                    : Colors.black,
              ),
            ),
        ],
      ),
    );
  }
}
