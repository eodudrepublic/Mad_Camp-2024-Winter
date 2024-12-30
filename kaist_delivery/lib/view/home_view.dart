import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaist_delivery/controller/tab1/restaurant_controller.dart';
import 'package:kaist_delivery/controller/tab2/content_controller.dart';
import 'package:kaist_delivery/controller/tab3/pick_controller.dart';
import 'package:kaist_delivery/view/tab1/restaurant_view.dart';
import 'package:kaist_delivery/view/tab2/content_view.dart';
import 'package:kaist_delivery/view/tab3/pick_view.dart';
import '../common/widget/custom_bnb.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    ContentView(),
    const RestaurantView(),
    const PickView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // tab1, tab2, tab3의 컨트롤러를 lazy 방식으로 초기화
    Get.lazyPut(() => RestaurantController());
    Get.lazyPut(() => ContentController());
    Get.lazyPut(() => PickController());
  }
}
