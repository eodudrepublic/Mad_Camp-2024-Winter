import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:get/get.dart';
import 'package:sky_x_fe/view/navi/navi_view.dart';
import 'package:sky_x_fe/view/search/search_view.dart';
import 'package:sky_x_fe/view_model/navi/test_page.dart';
import 'common/key.dart';
import 'common/utils/logger.dart';
import 'package:sky_x_fe/view/map/map_view.dart';
import 'package:sky_x_fe/view/login/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 화면 세로 모드로 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // KakaoSdk 초기화
  KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);
  Log.info("KakaoSdk initialized");
  // Log.wtf("KakaoSdk initialized : ${await KakaoSdk.origin} -> 이게 왜 키 해쉬예요 ㅅㅂ");

  // NaverMapSdk 초기화
  await NaverMapSdk.instance.initialize(
    clientId: naverClientId,
    onAuthFailed: (ex) {
      Log.wtf("NaverMapSdk initialize fail : $ex");
    },
  );
  Log.info("NaverMapSdk initialized");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 860),
      builder: (context, child) {
        return GetMaterialApp(
          title: 'SkyX',
          debugShowCheckedModeBanner: false,
          initialRoute: '/test_navi',
          getPages: [
            /// 로그인
            GetPage(name: '/login', page: () => LoginView()),

            /// 지도 (홈)
            GetPage(name: '/map', page: () => SkyMapView()),

            /// 검색 (출발지, 도착지 설정)
            GetPage(name: '/search', page: () => SearchView()),

            /// 네비게이션 (경로 안내)
            GetPage(name: '/navi', page: () => NaviView()),
            GetPage(name: '/test_navi', page: () => const NaviTestPage()),
          ],
        );
      },
    );
  }
}
