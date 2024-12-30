import 'dart:math';
import 'package:get/get.dart';
import '../../model/pick.dart';

class PickController extends GetxController {
  // '나의 Pick' 리스트
  var pickList = <Pick>[].obs;

  // 현재 추천된 메뉴
  var selectedPick = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // TODO : DB에서 받아오도록 기능 추가 -> DB도 추가해야함
    // 예시용 Pick 데이터 추가
    pickList.addAll([
      Pick(name: '떡볶이'),
      Pick(name: '치킨'),
      Pick(name: '피자'),
      Pick(name: '돈까스'),
      Pick(name: '치즈카츠'),
      Pick(name: '우동'),
      Pick(name: '제육볶음'),
      Pick(name: '짬뽕'),
      Pick(name: '쌀국수'),
      Pick(name: '감자튀김'),
      Pick(name: '보쌈'),
      Pick(name: '족발'),
      Pick(name: '육회'),
    ]);
  }

  // 리스트에서 랜덤으로 하나 선택
  void getRandomPick() {
    if (pickList.isEmpty) {
      selectedPick.value = '';
      return;
    }
    final randomIndex = Random().nextInt(pickList.length);
    selectedPick.value = pickList[randomIndex].name;
  }
}
