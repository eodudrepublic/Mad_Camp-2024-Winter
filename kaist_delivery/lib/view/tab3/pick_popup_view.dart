import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';
import '../../common/app_colors.dart';

class PickPopupView extends StatefulWidget {
  const PickPopupView({Key? key, required this.pick}) : super(key: key);

  final String pick; // 선택된 Pick을 전달받음

  @override
  State<PickPopupView> createState() => _PickPopupViewState();
}

class _PickPopupViewState extends State<PickPopupView>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  bool showPick = false; // Pick을 표시할지 여부를 결정하는 상태 변수
  bool startTextAnimation = false; // 글씨 애니메이션 시작 여부

  @override
  void initState() {
    super.initState();

    // 팝업 표시 애니메이션
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    // 확대 축소 애니메이션 컨트롤러
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    // 불투명도 애니메이션
    _opacityAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    // 확대 축소 애니메이션
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_scaleController);

    _fadeController.forward(); // 팝업 표시 애니메이션 시작

    // 글씨 애니메이션 일정 시간 후 시작
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        startTextAnimation = true;
      });

      // Pick 표시를 일정 시간 후에 활성화
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          showPick = true;
        });

        // 확대 축소 애니메이션 시작
        _scaleController.forward().then((_) {
          _scaleController.reverse(); // 다시 축소
        });

        // 팝업 자동 닫기
        Future.delayed(const Duration(seconds: 4), () {
          _fadeController.reverse().then((_) => Get.back());
        });
      });
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.6), // 반투명 배경
        body: Center(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icon/background_image.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 40.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 한 글자씩 나타나는 애니메이션 텍스트
                  if (startTextAnimation)
                    SizedBox(
                      height: 100.sp,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            ' 오늘의 Pick은?!?!? ',
                            textStyle: TextStyle(
                              fontFamily: "Titlefont",
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            speed: const Duration(milliseconds: 150),
                          ),
                        ],
                        isRepeatingAnimation: false,
                      ),
                    ),
                  SizedBox(height: 30.sp),

                  // 뽑힌 Pick 텍스트를 검정 테두리가 있는 사각형 안에 배치
                  if (showPick)
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // 테두리 텍스트
                          Text(
                            widget.pick,
                            style: TextStyle(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Titlefont",
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2.sp
                                ..color = Colors.black, // 테두리 색상
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // 내부 텍스트
                          Text(
                            widget.pick,
                            style: TextStyle(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Titlefont",
                              color: AppColors.mainThemeDarkColor, // 글씨 색상
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
