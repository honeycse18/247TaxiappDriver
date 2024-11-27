import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/utils/constansts/app_pages_name.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RawButtonWidget(
                onTap: () {
                  Helper.logout();
                },
                child: Text('logout')),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppPageNames.editDocumentsScreen);
                },
                child: Text('OK'))
          ],
        ),
      ),
    );
  }
}
