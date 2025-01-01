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
        leftIconWidget: const Icon(Icons.arrow_back, color: Colors.black, size: 31,),
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
                      horizontal: 10.sp,
                    ),
                    child: SizedBox(
                      height: 40.0, // 높이를 텍스트 크기와 일치시키기
                      child: Center( // 텍스트를 정확히 가운데 정렬
                        child: TextField(
                          controller: editController,
                          decoration: const InputDecoration(
                            hintText: '새로운 Pick을 입력해주세요.',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero, // 내부 여백 제거
                          ),
                          style: TextStyle(
                            fontSize: 16.sp, // 텍스트 크기 설정
                          ),
                          cursorColor: Colors.black,
                        ),
                      ),
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
                          fontSize: 15.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            ),
          ),
          // "나의 Pick 목록" 헤더
          Container(
            padding: EdgeInsets.only(left: 20.sp, right: 20.sp, top: 15.sp),
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

                            return AlertDialog(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), // 모서리 둥글게
                                side: BorderSide(color: AppColors.mainThemeColor, width: 2.0), // 테두리 색 검정으로 설정
                              ),
                              title: const Text('Pick 수정하기', style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600,
                              ),),
                              content: TextField(
                                controller: dialogEditController,
                                cursorColor: AppColors.mainThemeColor,
                                decoration: const InputDecoration(
                                  hintText: 'Pick 이름을 수정하세요.',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey), // 비활성 상태 밑줄 색상
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: AppColors.mainThemeColor, width: 2.0), // 활성 상태 밑줄 색상
                                  ),
                                ),
                              ),
                              actions: [
                                // -----------------------------
                                // 삭제 버튼
                                // -----------------------------
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 버튼 사이 간격 조정
                              children: [
                                // 삭제 버튼
                                TextButton(
                                  onPressed: () {
                                    // 삭제 메서드
                                    controller.deletePick(pick.name);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    '삭제',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10), // 버튼 간 간격 추가
                                // 완료(수정) 버튼
                                TextButton(
                                  onPressed: () {
                                    final newName = dialogEditController.text.trim();
                                    if (newName.isNotEmpty) {
                                      // 이름 업데이트
                                      controller.updatePick(pick.name, newName);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    '완료',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
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
