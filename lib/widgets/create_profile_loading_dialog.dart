import 'package:flutter/material.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoadingDialog extends StatelessWidget {
  final String? title;

  const CustomLoadingDialog({super.key, this.title = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      contentWidget: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppGaps.hGap32,
              const SizedBox(
                height: 27,
                width: 27,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballSpinFadeLoader,
                  colors: [AppColors.primaryColor],
                ),
              ),
              AppGaps.hGap20,
              Text(title ?? 'Loading...',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLargeMediumTextStyle),
              AppGaps.hGap40,
            ],
          ),
        ),
      ),
    );
  }
}
