import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaist_delivery/view/home_view.dart';   // 스플래시 이후 이동할 화면


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);



    _controller.forward();
    Future.delayed(Duration(seconds: 2), () {
      _navigateToHome();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHome(){
    Get.off(() => const HomeView(),
        transition: Transition.zoom, // 전환 애니메이션 설정
        duration: Duration(milliseconds: 1200)); // 애니메이션 지속 시간
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              '배고픈 카이스티안을 위한',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            Text(
              'K-밥심',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Image.asset(
              'assets/icon/main_icon.png', // 로고 이미지
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
