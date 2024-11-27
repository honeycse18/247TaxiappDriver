import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/add_vehicle_screen_controller.dart';

class ColorPickerDialog extends StatelessWidget {
  ColorPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddVehicleScreenController>(
        global: false,
        init: AddVehicleScreenController(),
        builder: (controller) => AlertDialog(
              title: const Text('Pick a color'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  paletteType: PaletteType.hueWheel,
                  pickerColor: controller.selectedColor,
                  onColorChanged: controller.updateColor,
                  showLabel: true,
                  pickerAreaHeightPercent: 0.8,
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Done'),
                  onPressed: () {
                    Get.back(result: controller.selectedColor);
                  },
                ),
              ],
            ));
  }
}
