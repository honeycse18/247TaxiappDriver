import 'package:get/get.dart';

class YearPickerScreenController extends GetxController {
  Rx<DateTime> selectedModelYear = DateTime.now().obs;
  // DateTime _selectedModelYear = DateTime.now();
  /* get selectedModelYear => _selectedModelYear;
  set selectedModelYear(value) {
    _selectedModelYear = value;
    update();
  } */

  // final TextEditingController yearController = TextEditingController();

  void updateSelectedEndDate(DateTime endDate) {
    selectedModelYear.value = endDate;
    Get.back(result: endDate);
  }
}
