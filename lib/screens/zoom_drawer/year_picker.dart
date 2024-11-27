import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/yearpicker_controller.dart';

class YearPickerScreen extends StatelessWidget {
  const YearPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<YearPickerScreenController>(
        init: YearPickerScreenController(),
        global: false,
        builder: (controller) => AlertDialog(
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.height * 0.4,
                child: Obx(() => YearPicker(
                      dragStartBehavior: DragStartBehavior.values[0],
                      firstDate: DateTime(1800),
                      lastDate: DateTime.now(),
                      currentDate: DateTime.now(),
                      selectedDate: controller.selectedModelYear.value,
                      onChanged: (value) {
                        controller.updateSelectedEndDate(value);
                      },
                    )),
              ),
            ));
  }
}
