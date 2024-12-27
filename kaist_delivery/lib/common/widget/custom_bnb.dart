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
          border: Border(top: BorderSide(color: Colors.black, width: 1.sp))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 아이콘 간격 균등 분배
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildIconButton(
            icon: SvgPicture.asset(
              currentIndex == 0
                  ? 'assets/svg/food_on.svg'
                  : 'assets/svg/food_off.svg',
              height: (iconHeight * (5 / 4)).sp,
              width: (iconWidth * (5 / 4)).sp,
            ),
            isSelected: currentIndex == 0,
            onTap: () => onTap(0),
          ),
          _buildIconButton(
            icon: SvgPicture.asset(
              currentIndex == 1
                  ? 'assets/svg/menu_on.svg'
                  : 'assets/svg/menu_off.svg',
              height: iconHeight.sp,
              width: iconWidth.sp,
            ),
            isSelected: currentIndex == 1,
            onTap: () => onTap(1),
          ),
          _buildIconButton(
            icon: SvgPicture.asset(
              currentIndex == 2
                  ? 'assets/svg/search_on.svg'
                  : 'assets/svg/search_off.svg',
              height: (iconHeight * (11 / 9)).sp,
              width: (iconWidth * (11 / 9)).sp,
            ),
            isSelected: currentIndex == 2,
            onTap: () => onTap(2),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required Widget icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: icon,
    );
  }
}
