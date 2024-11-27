import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class ProfileScreenController extends GetxController {
  int _radioVal = 0;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  CountryCode currentCountryCode = CountryCode.fromCountryCode('GB');
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController drivingLicenseTextEditingController =
      TextEditingController();

  bool isUpdateProfileOptionSelected = true;

  void onCountryChange(CountryCode countryCode) {
    currentCountryCode = countryCode;
    update();
  }

  Widget updateProfileTabWidget(
      {String title = 'Title', bool isSelected = false, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
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

  Widget documentsTextFormField() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: drivingLicenseTextEditingController,
                labelText: 'Driving License',
                hintText: 'Capture',
                prefixIcon:
                    const SvgPictureAssetWidget(AppAssetImages.cardSVGLogoLine),
                suffixIcon: const SvgPictureAssetWidget(
                    AppAssetImages.rightArrowSVGLogoLine),
              ),
            ),
            AppGaps.wGap16,
            Expanded(
              child: CustomTextFormField(
                controller: drivingLicenseTextEditingController,
                labelText: 'Expire Date',
                hintText: '-Select-',
                prefixIcon:
                    const SvgPictureAssetWidget(AppAssetImages.cardSVGLogoLine),
                suffixIcon: const SvgPictureAssetWidget(
                    AppAssetImages.rightArrowSVGLogoLine),
              ),
            ),
          ],
        ),
        AppGaps.hGap24,
        CustomTextFormField(
          controller: drivingLicenseTextEditingController,
          labelText: 'Id Card',
          hintText: 'Capture',
          prefixIcon:
              const SvgPictureAssetWidget(AppAssetImages.cardSVGLogoLine),
          suffixIcon:
              const SvgPictureAssetWidget(AppAssetImages.rightArrowSVGLogoLine),
        ),
        AppGaps.hGap24,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: drivingLicenseTextEditingController,
                labelText: 'Driver Badge',
                hintText: 'Capture',
                prefixIcon:
                    const SvgPictureAssetWidget(AppAssetImages.cardSVGLogoLine),
                suffixIcon: const SvgPictureAssetWidget(
                    AppAssetImages.rightArrowSVGLogoLine),
              ),
            ),
            AppGaps.wGap16,
            Expanded(
              child: CustomTextFormField(
                controller: drivingLicenseTextEditingController,
                labelText: 'Badge Number',
                hintText: 'Ex.12345',
                prefixIcon:
                    const SvgPictureAssetWidget(AppAssetImages.cardSVGLogoLine),
                suffixIcon: const SvgPictureAssetWidget(
                    AppAssetImages.rightArrowSVGLogoLine),
              ),
            ),
          ],
        ),
        AppGaps.hGap24,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: drivingLicenseTextEditingController,
                labelText: 'Driver NI',
                hintText: 'Capture',
                prefixIcon:
                    const SvgPictureAssetWidget(AppAssetImages.cardSVGLogoLine),
                suffixIcon: const SvgPictureAssetWidget(
                    AppAssetImages.rightArrowSVGLogoLine),
              ),
            ),
            AppGaps.wGap16,
            Expanded(
              child: CustomTextFormField(
                controller: drivingLicenseTextEditingController,
                labelText: 'NI Number',
                hintText: 'Ex.12345',
                prefixIcon:
                    const SvgPictureAssetWidget(AppAssetImages.cardSVGLogoLine),
                suffixIcon: const SvgPictureAssetWidget(
                    AppAssetImages.rightArrowSVGLogoLine),
              ),
            ),
          ],
        ),
        AppGaps.hGap24,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: drivingLicenseTextEditingController,
                labelText: 'Enhance DBS',
                hintText: 'Capture',
                prefixIcon:
                    const SvgPictureAssetWidget(AppAssetImages.cardSVGLogoLine),
                suffixIcon: const SvgPictureAssetWidget(
                    AppAssetImages.rightArrowSVGLogoLine),
              ),
            ),
            AppGaps.wGap16,
            Expanded(
              child: CustomTextFormField(
                controller: drivingLicenseTextEditingController,
                labelText: 'DBS Number',
                hintText: '24 -Apr-2024',
                prefixIcon:
                    const SvgPictureAssetWidget(AppAssetImages.cardSVGLogoLine),
                suffixIcon: const SvgPictureAssetWidget(
                    AppAssetImages.rightArrowSVGLogoLine),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget personalInfoTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: nameTextEditingController,
          validator: Helper.textFormValidator,
          labelText: 'Full Name',
          hintText: 'Liton Nandi',
          prefixIcon:
              const SvgPictureAssetWidget(AppAssetImages.profileSVGLogoLine),
        ),
        AppGaps.hGap24,
        CustomTextFormField(
            validator: Helper.emailFormValidator,
            controller: emailTextEditingController,
            labelText: 'Email',
            hintText: 'eg: abc@example.com',
            prefixIcon:
                const SvgPictureAssetWidget(AppAssetImages.emailSVGLogoLine)),
        AppGaps.hGap24,
        const Text('Phone Number'),
        AppGaps.hGap8,
        CustomPhoneNumberTextFormFieldWidget(
          initialCountryCode: currentCountryCode,
          controller: phoneTextEditingController,
          hintText: '01403224486',
          onCountryCodeChanged: onCountryChange,
        ),
        AppGaps.hGap24,
        const Text(
          'Gender',
          style: AppTextStyles.bodyLargeMediumTextStyle,
        ),
        AppGaps.hGap5,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 56,
              width: 163,
              decoration: const BoxDecoration(color: AppColors.shade1),
              child: Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: _radioVal,
                    onChanged: (int? value) {},
                  ),
                  const Text('Male '),
                ],
              ),
            ),
            Container(
              height: 56,
              width: 163,
              decoration: const BoxDecoration(color: AppColors.shade1),
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: _radioVal,
                    onChanged: (int? value) {},
                  ),
                  const Text('Female ')
                ],
              ),
            ),
          ],
        ),
        AppGaps.hGap24,
        CustomTextFormField(
            controller: addressTextEditingController,
            labelText: 'Address',
            isReadOnly: true,
            hintText: 'Khulna',
            prefixIcon:
                SvgPicture.asset(AppAssetImages.pickLocationSVGLogoLine)),
      ],
    );
  }

  void onRegisterButtonTap() {
    //Get.toNamed(AppPageNames.verificationScreen);
  }
}
