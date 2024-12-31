import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaist_delivery/common/app_colors.dart';
import 'package:kaist_delivery/common/widget/custom_appbar.dart';
import '../../controller/tab3/pick_controller.dart';

class EditListView extends StatefulWidget {
  const EditListView({super.key});

  @override
  State<EditListView> createState() => _EditListViewState();
}

class _EditListViewState extends State<EditListView> {
  // 새 Pick을 추가할 때 사용하는 TextField 컨트롤러
  final TextEditingController editController = TextEditingController();

  // PickController 주입
  final PickController controller = Get.put(PickController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leftIconPath: 'assets/icon/back_icon.png',
        onLeftIconTap: () {
          Get.back();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 상단 영역: 텍스트 입력 + "Pick 추가" 버튼
          Container(
            color: AppColors.mainThemeColor,
            height: 0.075.sh,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1.sp),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10.sp,
                    ),
                    child: TextField(
                      controller: editController,
                      decoration: const InputDecoration(
                        hintText: '새로운 Pick을 입력해주세요.',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 0,
                        ),
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    final text = editController.text.trim();
                    // 빈칸이 아니면 Pick 추가
                    if (text.isNotEmpty) {
                      controller.addPick(text);
                      // 텍스트 초기화
                      editController.clear();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 15.sp),
                    child: Text(
                      "Pick 추가",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          // "나의 Pick 목록" 헤더
          Container(
            padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 10.sp),
            alignment: Alignment.centerLeft,
            child: Text(
              '나의 Pick 목록',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // -----------------------------
          // Pick 리스트 (Obx로 상태관리)
          // -----------------------------
          Expanded(
            child: Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: ListView.builder(
                  itemCount: controller.pickList.length,
                  itemBuilder: (context, index) {
                    final pick = controller.pickList[index];
                    final bool isFirst = index == 0;
                    final bool isLast = index == controller.pickList.length - 1;

                    return GestureDetector(
                      onTap: () {
                        // 다이얼로그를 띄워서 수정/삭제
                        showDialog(
                          context: context,
                          builder: (context) {
                            // 현재 Pick 이름을 표시하는 Dialog 내 TextField
                            final TextEditingController dialogEditController =
                                TextEditingController(text: pick.name);

                            // TODO : AlertDialog 디자인 좀 수정해주세요...
                            return AlertDialog(
                              title: const Text('Pick 수정/삭제'),
                              content: TextField(
                                controller: dialogEditController,
                                decoration: const InputDecoration(
                                  hintText: 'Pick 이름을 수정하세요.',
                                ),
                              ),
                              actions: [
                                // -----------------------------
                                // 삭제 버튼
                                // -----------------------------
                                TextButton(
                                  onPressed: () {
                                    // 삭제 메서드
                                    controller.deletePick(pick.name);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('삭제'),
                                ),
                                // -----------------------------
                                // 완료(수정) 버튼
                                // -----------------------------
                                TextButton(
                                  onPressed: () {
                                    final newName =
                                        dialogEditController.text.trim();
                                    if (newName.isNotEmpty) {
                                      // 이름 업데이트
                                      controller.updatePick(pick.name, newName);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('완료'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.listBackgroundColor,
                          borderRadius: BorderRadius.only(
                            topLeft:
                                isFirst ? Radius.circular(10.r) : Radius.zero,
                            topRight:
                                isFirst ? Radius.circular(10.r) : Radius.zero,
                            bottomLeft:
                                isLast ? Radius.circular(10.r) : Radius.zero,
                            bottomRight:
                                isLast ? Radius.circular(10.r) : Radius.zero,
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 1.5.sp),
                        padding: EdgeInsets.all(12.sp),
                        child: Text(
                          pick.name,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
