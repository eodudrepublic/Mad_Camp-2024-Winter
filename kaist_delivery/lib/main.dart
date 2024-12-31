import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaist_delivery/view/home_view.dart';
import 'package:kaist_delivery/view/tab1/restaurant_view.dart';
import 'package:kaist_delivery/view/tab2/content_view.dart';
import 'package:kaist_delivery/view/tab1/search_view.dart';
import 'package:kaist_delivery/view/tab3/edit_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 850),
      child: GetMaterialApp(
        theme: ThemeData(fontFamily: "Pretendard"),
        initialRoute: '/home',
        getPages: [
          GetPage(
              name: '/home',
              page: () => const HomeView(),
              binding: HomeBinding()),
          GetPage(
              name: '/home/restaurants', page: () => const RestaurantView()),
          GetPage(name: '/home/contents', page: () => ContentView()),
          GetPage(name: '/home/contents/edit', page: () => EditListView()),
          GetPage(name: '/search', page: () => const SearchView()),
        ],
      ),
    );
  }
}
