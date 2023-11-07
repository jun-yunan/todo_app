import 'package:get/state_manager.dart';
import 'package:todo_app/utils/utils.dart';

class NavigationBarAction extends GetxController {
  RxBool selectButton = RxBool(false);

  RxInt currentIndexPage = RxInt(0);

  void setCurrentIndex(int index) {
    currentIndexPage.value = index;
  }

  void setSelectButton() {
    selectButton.value = !selectButton.value;
  }

  void showSnack() {
    showSnackbar(message: "message");
  }
}
