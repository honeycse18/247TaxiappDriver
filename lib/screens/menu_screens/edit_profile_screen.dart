import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:taxiappdriver/controller/edit_profile_screen_controller.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_language_translations.dart';
import 'package:taxiappdriver/utils/extensions/string.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileScreenController>(
        global: false,
        init: EditProfileScreenController(),
        builder: (controller) => Scaffold(
              extendBody: true,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText: 'Edit Profile',
                  hasBackButton: true,
                  actions: [
                    controller.userDetails.status == 'pending'
                        ? Container(
                            width: 63,
                            height: 26,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFFFBEA),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            child: const Center(
                              child: Text(
                                'Pending',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFFFF9500),
                                  fontSize: 12,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        : controller.userDetails.status == 'approved'
                            ? Container(
                                width: 63,
                                height: 26,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFF4FAF3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Approved',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xFF45A245),
                                      fontSize: 12,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: 63,
                                height: 26,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFFF2F1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Suspended',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Color(0xFFFF392D),
                                      fontSize: 12,
                                      fontFamily: 'Urbanist',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                  ]),
              body: CustomScaffoldBodyWidget(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // / <---- Circular profile picture widget ----> /
                          /* controller.imageEdit
                              ? SizedBox(
                                  height: 170,
                                  width: 170,
                                  child: CachedNetworkImageWidget(
                                    imageURL: controller.userDetails.image,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border:
                                              Border.all(color: Colors.black),
                                          image: DecorationImage(
                                              image: Image.memory(
                                            controller.selectedProfileImage,
                                          ).image)),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 170,
                                  width: 170,
                                  child: CachedNetworkImageWidget(
                                    imageURL: controller.userDetails.image,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border:
                                              Border.all(color: Colors.black),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ), */

                          SizedBox(
                            height: 170,
                            width: 170,
                            child: controller.imageEdit
                                ? MixedImageWidget(
                                    imageURL: controller.selectedProfileImage,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(
                                                  color: Colors.black),
                                              image: DecorationImage(
                                                  image: imageProvider)),
                                        ))
                                : CachedNetworkImageWidget(
                                    imageURL: controller.userDetails.image,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border:
                                              Border.all(color: Colors.black),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.contain)),
                                    ),
                                  ),
                          ),
                          if (controller.isEditing)
                            Positioned(
                              bottom: -10,
                              right: 65,
                              child: Container(
                                height: 34,
                                width: 34,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    color: AppColors.primaryColor),
                                child: RawButtonWidget(
                                  onTap: controller.isEditing
                                      ? controller.onEditImageButtonTap
                                      : null,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AppAssetImages.cameraSVGLogoLine,
                                      height: 14,
                                      width: 14,
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                      /* <-------- SignUp Form --------> */
                      AppGaps.hGap20,
                      AppGaps.hGap20,
                      /*<-------Text field for full name ------>*/
                      CustomTextFormField(
                          validator: Helper.textFormValidator,
                          controller: controller.nameTextEditingController,
                          labelText: AppLanguageTranslation
                              .fullNameTransKey.toCurrentLanguage,
                          hintText: controller.userDetails.name,
                          prefixIcon: const SvgPictureAssetWidget(
                            AppAssetImages.profileSVGLogoLine,
                            color: AppColors.bodyTextColor,
                          ),
                          isReadOnly: !controller.isEditing),
                      AppGaps.hGap16,
                      /*<-------Text field for email ------>*/
                      CustomTextFormField(
                          isReadOnly: true,
                          controller: controller.emailTextEditingController,
                          labelText: 'Email Address',
                          hintText: controller.userDetails.email,
                          prefixIcon: SvgPicture.asset(
                            AppAssetImages.emailSVGLogoLine,
                          )),
                      AppGaps.hGap16,
                      PhoneNumberTextFormFieldWidget(
                        isReadOnly: true,
                        initialCountryCode: controller.currentCountryCode,
                        controller: controller.phoneTextEditingController,
                        labelText: AppLanguageTranslation
                            .phoneNumberTransKey.toCurrentLanguage,
                        hintText: controller.phoneNumber,
                        onTap: () {},
                        onCountryCodeChanged: (p0) {},
                      ),
                      AppGaps.hGap16,
                      CustomTextFormField(
                          onTap: controller.isEditing
                              ? controller.onAddressTap
                              : null,
                          controller: controller.addressTextEditingController,
                          labelText: AppLanguageTranslation
                              .addressTransKey.toCurrentLanguage,
                          hintText: controller.userDetails.address,
                          prefixIcon: const SvgPictureAssetWidget(
                            AppAssetImages.pickupSVGLogoLine,
                            color: AppColors.bodyTextColor,
                          ),
                          isReadOnly: !controller.isEditing),
                      AppGaps.hGap16,
                      /*<------- Gender Dropdown ------>*/
                      DropdownButtonFormFieldWidget<String>(
                        validator: (value) =>
                            value == null ? 'Please select a gender' : null,
                        labelText: 'Gender',
                        hintText: 'e.g. Male',
                        value: controller.selectedGender,
                        items: const ['male', 'female', 'other'],
                        getItemTextIndex: (i, p0) => '${p0.capitalizeFirst}',
                        onChanged: controller.isEditing
                            ? (selectedItem) {
                                controller.selectGender(selectedItem!);
                              }
                            : null,
                      ),
                      AppGaps.hGap16,
                      AppGaps.hGap114,
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: ScaffoldBodyWidget(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    controller.isEditing
                        ? StretchedTextButtonWidget(
                            isLoading: controller.isLoading,
                            onTap: controller.editActive
                                ? controller.onSaveChangesButtonTap
                                : null,
                            buttonText: 'Save Profile')
                        : StretchedTextButtonWidget(
                            isLoading: controller.isLoading,
                            onTap: controller.onEditProfileButtonTap,
                            buttonText: 'Edit Profile'),
                    AppGaps.hGap20,
                  ],
                ),
              ),
            ));
  }
}
