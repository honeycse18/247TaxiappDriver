import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/model/fakeModel/enam.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';

class ForgotPasswordSCreenController extends GetxController {
  Rx<ForgotPasswordOptionListEnum> serviceTab =
      ForgotPasswordOptionListEnum.email.obs;

  bool isSendCodeOptionSelected = true;

  TextEditingController emailTextEditingController = TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('GB');
  TextEditingController phoneTextEditingController = TextEditingController();

  void onserviceTabTap(ForgotPasswordOptionListEnum value) {
    serviceTab.value = value;
    update();
  }

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
  }

  Widget forgotPasswordTabWidget(
      {String title = 'Title', bool isSelected = false, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          /* border: Border.all(
            width: 1,
            color: isSelected ? AppColors.curveBorderColor : Colors.transparent,
          ), */
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: isSelected
                    ? AppColors.primaryColor
                    : AppColors.primaryTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

/* class ForgotPasswordOption extends StatelessWidget {
  final String categoryTitle;
  final void Function()? onTap;
  final bool isSelected;

  const ForgotPasswordOption({
    super.key,
    required this.categoryTitle,
    required this.onTap,
    required this.isSelected,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: 117,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.textColor : AppColors.shade1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            categoryTitle,
            style: AppTextStyles.bodyMediumTextStyle,
            selectionColor: isSelected
                ? AppColors.curveBorderColor
                : AppColors.bodyTextColor,
          ),
        ),
      ),
    );
  }
}
 */
