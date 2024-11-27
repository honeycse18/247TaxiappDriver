import 'package:flutter/material.dart';
import 'package:taxiappdriver/model/api_response/withdraw_methods_response.dart';
import 'package:taxiappdriver/model/fakeModel/payment_option_model.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

/// Payment option list tile widget from checkout screen
class SelectWithdrawMethodWidget extends StatelessWidget {
  const SelectWithdrawMethodWidget({
    super.key,
    required this.hasShadow,
    required this.paymentOption,
    required this.paymentOptionImage,
    required this.index,
    required this.selectedPaymentOptionIndex,
    required this.radioOnChange,
    this.onTap,
    required this.cancelReason,
    required this.selectedCancelReason,
  });

  final bool hasShadow;
  final String paymentOption;
  final String paymentOptionImage;
  final int index;
  final SavedWithdrawMethods cancelReason;
  final SavedWithdrawMethods selectedCancelReason;
  final int selectedPaymentOptionIndex;
  final void Function(Object?) radioOnChange;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomPaymentListTileWidget(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        hasShadow: hasShadow,
        paddingValue: const EdgeInsets.all(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 62,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: AppColors.curveColor)),
          child: Row(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CachedNetworkImageWidget(
                  imageURL: paymentOptionImage,
                  imageBuilder: (context, imageProvider) => Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.contain)),
                  ),
                ),
              ),
              AppGaps.wGap15,
              Expanded(
                  child: Text(
                paymentOption,
                style: const TextStyle(fontWeight: FontWeight.w600),
              )),
              AppGaps.wGap16,
              CustomRadioWidget(
                  value: index,
                  groupValue: selectedPaymentOptionIndex,
                  onChanged: radioOnChange),
            ],
          ),
        ));
  }
}
