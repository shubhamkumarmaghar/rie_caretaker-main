import 'package:get/get.dart';

import '../controllers/move_in_out_controller.dart';

class VisitInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoveInOutController>(
      () => MoveInOutController(),
    );
  }
}
