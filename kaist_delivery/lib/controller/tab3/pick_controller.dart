import 'dart:math';
import 'package:get/get.dart';
import '../../database/model/pick_model.dart';
import '../../model/pick.dart';
import '../../database/repository/pick_repository.dart';
import '../../view/tab3/pick_popup_view.dart';

class PickController extends GetxController {
  // '나의 Pick' 리스트 (UI에서 사용할 모델)
  var pickList = <Pick>[].obs;

  // 애니메이션 상태를 관리
  var isAnimating = false.obs;

  // 현재 추천된 메뉴
  var selectedPick = ''.obs;

  // PickRepository 객체
  final PickRepository _pickRepository = PickRepository();

  @override
  void onInit() {
    super.onInit();
    // 1) DB에서 데이터를 받아와 pickList에 저장
    _loadPicksFromDB();

    /// TEST
    //addPick(DateTime.now().toString());
    // _pickRepository.deleteAllPicks();
  }

  /// -----------------------------
  /// 1) onInit()에서 DB → pickList
  /// -----------------------------
  Future<void> _loadPicksFromDB() async {
    // DB에서 전체 PickModel을 가져옴
    List<PickModel> pickModels = await _pickRepository.getAllPicks();

    // DB 모델(PickModel)을 UI 모델(Pick)로 변환하여 pickList에 저장
    pickList.value = pickModels.map((p) => Pick(name: p.name)).toList();
  }

  /// -----------------------------
  /// 2) Pick 추가
  /// -----------------------------
  Future<void> addPick(String name) async {
    // DB에 insert
    await _pickRepository.insertPick(PickModel(name: name));

    // pickList에도 반영
    pickList.add(Pick(name: name));
  }

  /// -----------------------------
  /// 3) Pick 삭제
  /// -----------------------------
  Future<void> deletePick(String name) async {
    // DB에서 삭제
    await _pickRepository.deletePickByName(name);

    // pickList에서도 제거
    pickList.removeWhere((p) => p.name == name);
  }

  /// -----------------------------
  /// 4) Pick 수정
  /// -----------------------------
  Future<void> updatePick(String oldName, String newName) async {
    // DB에서 oldName → newName 으로 수정
    await _pickRepository.updatePickName(oldName, newName);

    // pickList에서 oldName을 찾아 newName으로 교체
    final index = pickList.indexWhere((p) => p.name == oldName);
    if (index != -1) {
      pickList[index] = Pick(name: newName);
    }
  }

  /// -----------------------------
  /// 랜덤으로 Pick 선택
  /// -----------------------------
  void getRandomPick() {
    if (pickList.isEmpty) {
      selectedPick.value = '';
      return;
    }
    final randomIndex = Random().nextInt(pickList.length);
    selectedPick.value = pickList[randomIndex].name;
  }

  /// 애니메이션 시작
  void startPickAnimation() async {
    isAnimating.value = true;
    getRandomPick(); // 랜덤 Pick 선택
    Get.dialog(
      PickPopupView(pick: selectedPick.value),
      barrierDismissible: false,
    );

    isAnimating.value = false;
  }
}
