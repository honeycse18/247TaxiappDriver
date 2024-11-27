import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:taxiappdriver/model/fakeModel/fake_data.dart';
import 'package:taxiappdriver/model/fakeModel/intro_content_model.dart';

class CancelReasonRideBottomSheetController extends GetxController {
  /*<----------- Initialize variables ----------->*/
  int selectedReasonIndex = -1;
  TextEditingController otherReasonTextController = TextEditingController();
  FakeCancelRideReason selectedCancelReason = FakeCancelRideReason();

  /* <---- Submit button tap ----> */
  onSubmitButtonTap() {
    String reason = selectedCancelReason.reasonName == 'Other'
        ? otherReasonTextController.text
        : FakeData.cancelRideReason[selectedReasonIndex].reasonName;

    Get.back(result: reason);
  }
}
