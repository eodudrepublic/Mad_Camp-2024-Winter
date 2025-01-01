import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// 왼쪽 아이콘 위젯 (Flutter Icon 사용 가능)
  /// `leftIconPath`와 함께 사용할 수 없음
  final Widget? leftIconWidget;

  /// 왼쪽 아이콘 이미지 경로
  final String? leftIconPath;

  /// 왼쪽 아이콘 터치 시 동작
  final VoidCallback? onLeftIconTap;

  /// 가운데 제목
  final String? titleText;

  /// 가운데 임의의 위젯
  final Widget? centerWidget;

  /// 오른쪽 아이콘 위젯 (Flutter Icon 사용 가능)
  /// `rightIconPath`와 함께 사용할 수 없음
  final Widget? rightIconWidget;

  /// 오른쪽 아이콘 이미지 경로
  final String? rightIconPath;

  /// 오른쪽 아이콘 터치 시 동작
  final VoidCallback? onRightIconTap;

  const CustomAppBar({
    super.key,
    this.leftIconWidget,
    this.leftIconPath,
    this.onLeftIconTap,
    this.titleText,
    this.centerWidget,
    this.rightIconWidget,
    this.rightIconPath,
    this.onRightIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mainThemeColor,
      automaticallyImplyLeading: false,
      // 가운데 영역
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1-1. 왼쪽 아이콘 (기본 아이콘)
          if (leftIconWidget != null)
            GestureDetector(
              onTap: onLeftIconTap,
              child: leftIconWidget,
            )
          else
            GestureDetector(
              onTap: onLeftIconTap,
              child: Image.asset(
                leftIconPath ?? 'assets/icon/main_icon.png',
                height: 32.sp,
                width: 32.sp,
              ),
            ),
          SizedBox(width: 8.sp),
          // 2-2. 가운데 위젯
          if (centerWidget != null)
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(left: 15.sp),
                    alignment: Alignment.centerRight,
                    child: centerWidget!))
          // 2-1. 가운데 제목
          else if (titleText != null)
            Text(
              titleText!,
              style: TextStyle(
                fontFamily: "Titlefont",
                color: Colors.black,
                fontSize: 20.sp,
              ),
            ),
        ],
      ),
      centerTitle: false,
      elevation: 0,
      // 3-1. 오른쪽 아이콘
      actions: [
        if (rightIconWidget != null)
          GestureDetector(
            onTap: onRightIconTap,
            child: Padding(
              padding: EdgeInsets.only(right: 10.sp),
              child: rightIconWidget,
            ),
          )
        else if (rightIconPath != null)
          GestureDetector(
            onTap: onRightIconTap,
            child: Padding(
              padding: EdgeInsets.only(right: 10.sp),
              child: Image.asset(
                rightIconPath!,
                height: 32.sp,
                width: 32.sp,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
