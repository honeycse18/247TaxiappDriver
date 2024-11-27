import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_components.dart';
import 'package:taxiappdriver/utils/constansts/app_constans.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/utils/helpers/helpers.dart';
import 'package:collection/collection.dart';
import 'package:taxiappdriver/widgets/create_profile_loading_dialog.dart';
import 'package:taxiappdriver/widgets/dotted_line.dart';

class CustomScaffold extends StatelessWidget {
  PreferredSizeWidget? appBar;
  final Widget? body;
  Widget? floatingActionButton;
  FloatingActionButtonLocation? floatingActionButtonLocation;
  FloatingActionButtonAnimator? floatingActionButtonAnimator;
  List<Widget>? persistentFooterButtons;
  AlignmentDirectional persistentFooterAlignment =
      AlignmentDirectional.centerEnd;
  Widget? drawer;
  void Function(bool)? onDrawerChanged;
  Widget? endDrawer;
  void Function(bool)? onEndDrawerChanged;
  Widget? bottomNavigationBar;
  Widget? bottomSheet;
  Color? backgroundColor;
  bool? resizeToAvoidBottomInset;
  bool primary = true;
  DragStartBehavior drawerDragStartBehavior = DragStartBehavior.start;
  bool extendBody = false;
  bool extendBodyBehindAppBar = false;
  Color? drawerScrimColor;
  double? drawerEdgeDragWidth;
  bool drawerEnableOpenDragGesture = true;
  bool endDrawerEnableOpenDragGesture = true;
  String? restorationId;

  CustomScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: false,
      extendBody: true,
      appBar: appBar,
      body: Container(
        height: screenHeight,
        // clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
            //color: AppColors.backgroundColor,
            ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.28,
                decoration: const ShapeDecoration(
                  //color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  // heightFactor: screenHeight * 0.85,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: screenWidth,
                    // height: screenHeight * 0.85,
                    decoration: const ShapeDecoration(
                      //color: AppColors.primaryButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    child: body,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      drawerDragStartBehavior: drawerDragStartBehavior,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
      drawerScrimColor: drawerScrimColor,
      endDrawer: endDrawer,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      floatingActionButtonLocation: floatingActionButtonLocation,
      onDrawerChanged: onDrawerChanged,
      key: key,
      onEndDrawerChanged: onEndDrawerChanged,
      persistentFooterAlignment: persistentFooterAlignment,
      persistentFooterButtons: persistentFooterButtons,
      primary: primary,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      restorationId: restorationId,
    );
  }
}

/// Slogan and subtitle text
class IntrolightAndDetailTextWidget extends StatelessWidget {
  final String slogan;
  final String subtitle;
  final bool isSpaceShorter;
  const IntrolightAndDetailTextWidget({
    Key? key,
    required this.slogan,
    required this.subtitle,
    this.isSpaceShorter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppGaps.hGap25,
          Text(
            slogan,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: AppTextStyles.titleMediumTextStyle
                .copyWith(color: Colors.white),
          ),
          isSpaceShorter ? AppGaps.hGap8 : AppGaps.hGap16,
          Text(subtitle,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: AppTextStyles.bodyMediumTextStyle
                  .copyWith(color: Colors.white)),
          AppGaps.hGap5,
        ],
      ),
    );
  }
}

/*<-------Highlight and details text widget-------->*/
class HighlightAndDetailTextWidget extends StatelessWidget {
  final String slogan;
  final String subtitle;
  final String params;
  final bool isSpaceShorter;
  final Color textColor;
  final Color subtextColor;
  final void Function()? onTap;

  const HighlightAndDetailTextWidget({
    Key? key,
    required this.slogan,
    required this.subtitle,
    required this.params,
    this.onTap,
    this.isSpaceShorter = false,
    this.textColor = AppColors.infoColor,
    this.subtextColor = AppColors.infoColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(slogan,
            textAlign: TextAlign.center,
            style: AppTextStyles.titleBoldTextStyle.copyWith(color: textColor)),
        isSpaceShorter ? AppGaps.hGap8 : AppGaps.hGap16,
        Text(subtitle,
            textAlign: TextAlign.left,
            style:
                AppTextStyles.bodyLargeTextStyle.copyWith(color: subtextColor)),
        AppGaps.hGap5,
        Row(
          children: [
            Text(params,
                textAlign: TextAlign.left,
                style: AppTextStyles.bodyLargeSemiboldTextStyle),
            AppGaps.wGap10,
            RawButtonWidget(
              onTap: onTap,
              child: Text('Edit',
                  style: AppTextStyles.bodyLargeSemiboldTextStyle.copyWith(
                      color: AppColors.primaryColor,
                      decoration: TextDecoration.underline)),
            )
          ],
        ),
      ],
    );
  }
}

class CustomStretchedButtonWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final void Function()? onTap;
  const CustomStretchedButtonWidget({
    Key? key,
    this.onTap,
    required this.child,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                elevation: 10,
                shadowColor: AppColors.primaryColor.withOpacity(0.25),
                backgroundColor: onTap == null
                    ? AppColors.backgroundColor
                    : AppColors.primaryColor,
                minimumSize: const Size(30, 54),
                maximumSize: const Size(30, 54),
                /* shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))) */
              ),
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : child),
        ),
      ],
    );
  }
}

class StretchedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color color;
  final Color fontColor;
  final bool isSmallSizedButton;
  final bool isLoading;
  final void Function()? onTap;
  const StretchedTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
    this.isLoading = false,
    this.backgroundColor = AppColors.primaryColor,
    this.color = Colors.white,
    this.fontColor = Colors.white,
    this.isSmallSizedButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonWidget(
              borderRadiusValue: 4,
              onTap: onTap,
              color: color,
              fixedSize: isSmallSizedButton ? null : const Size(250, 50),
              backgroundColor: backgroundColor,
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      buttonText,
                      style: AppTextStyles.bodyLargeSemiboldTextStyle
                          .copyWith(color: fontColor),
                    )),
        ),
      ],
    );
  }
}

class PhoneNumberTextFormFieldWidget extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final bool isRequired;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  final CountryCode? initialCountryCode;
  final bool isLabelWhiteText;
  final bool isFilled;
  final Color? fillColor;
  final void Function(CountryCode)? onCountryCodeChanged;
  const PhoneNumberTextFormFieldWidget({
    super.key,
    this.labelText,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.isRequired = false,
    this.initialCountryCode,
    this.onCountryCodeChanged,
    this.isLabelWhiteText = false,
    this.isFilled = false,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      labelText: labelText,
      prefixIconConstraints: const BoxConstraints(maxHeight: 32, maxWidth: 147),
      suffixIcon: suffixIcon,
      isPasswordTextField: isPasswordTextField,
      isReadOnly: isReadOnly,
      textInputType: TextInputType.phone,
      suffixIconConstraints: suffixIconConstraints,
      controller: controller,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines,
      fillColor: fillColor,
      isLabelWhiteText: isLabelWhiteText,
      isRequired: isRequired,
      onTap: onTap,
      prefixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CountryCodePicker(
            initialSelection: initialCountryCode?.code,
            onChanged: onCountryCodeChanged,
            builder: (country) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 25,
                    child: Image.asset(country?.flagUri ?? '',
                        package: 'country_code_picker'),
                  ),
                  AppGaps.wGap8,
                  const SvgPictureAssetWidget(
                      AppAssetImages.arrowDownSVGLogoLine,
                      color: AppColors.primaryTextColor),
                  AppGaps.wGap5,
                  Container(
                      height: 26, width: 2, color: AppColors.fromBorderColor),
                  AppGaps.wGap16,
                  Text(
                    country?.dialCode ?? '',
                    style: AppTextStyles.bodyTextStyle
                        .copyWith(color: AppColors.bodyTextColor),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      hintText: hintText,
    );
  }
}

class MixedImageWidget extends StatelessWidget {
  final dynamic imageURL;
  final BoxFit boxFit;
  final int? cacheHeight;
  final int? cacheWidth;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  const MixedImageWidget({
    Key? key,
    required this.imageURL,
    this.boxFit = BoxFit.cover,
    this.cacheHeight,
    this.cacheWidth,
    this.imageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeholderImageWidget = Image.asset(
        AppAssetImages.imagePlaceholderIconImage,
        fit: BoxFit.contain);
    final memoryImageWidget =
        Image.memory((imageURL is Uint8List) ? imageURL : Uint8List(0));
    if (imageURL is String) {
      return imageURL.isEmpty
          ? Image.asset(AppAssetImages.imagePlaceholderIconImage,
              fit: BoxFit.contain)
          : CachedNetworkImage(
              imageUrl: imageURL,
              placeholder: (context, url) =>
                  const LoadingImagePlaceholderWidget(),
              errorWidget: (context, url, error) =>
                  const ErrorLoadedIconWidget(),
              imageBuilder: imageBuilder,
              memCacheHeight: cacheHeight,
              memCacheWidth: cacheWidth,
              fit: boxFit);
    }
    if (imageURL is Uint8List) {
      return imageBuilder == null
          ? Image.memory(imageURL,
              fit: boxFit, cacheHeight: cacheHeight, cacheWidth: cacheWidth)
          : imageBuilder!.call(context, memoryImageWidget.image);
    }
    return imageBuilder == null
        ? placeholderImageWidget
        : imageBuilder!.call(context, placeholderImageWidget.image);
  }
}

class TextFormFieldWidget extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle hintTextStyle;
  final Widget? labelPrefixIcon;
  final bool isPasswordTextField;
  final bool isReadOnly;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final int? minLines;
  final int maxLines;
  final double suffixRightPaddingSize;
  final BoxConstraints prefixIconConstraints;
  final BoxConstraints suffixIconConstraints;
  final double prefixLeftPaddingSize;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final bool isFilled;
  final bool isLabelWhiteText;
  final bool isRequired;
  final Color? fillColor;
  final InputBorder? border;
  const TextFormFieldWidget({
    Key? key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.isPasswordTextField = false,
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.labelPrefixIcon,
    this.suffixRightPaddingSize = 24,
    this.hintTextStyle = AppTextStyles.bodyMediumTextStyle,
    this.prefixLeftPaddingSize = 24,
    this.validator,
    this.suffixIconConstraints = const BoxConstraints(maxHeight: 24),
    this.isFilled = true,
    this.fillColor,
    this.border,
    this.isLabelWhiteText = false,
    this.isRequired = false,
    this.prefixIconConstraints = const BoxConstraints(maxHeight: 24),
  }) : super(key: key);

  /// TextField widget
  Widget textFormFieldWidget() {
    return SizedBox(
      // height: (maxLines > 1 || (minLines ?? 1) > 1) ? null : 56,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        obscuringCharacter: '*',
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        minLines: minLines,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintTextStyle,
          border: border,
          enabledBorder: border,
          filled: isFilled,
          fillColor: fillColor,
          prefixIconConstraints: prefixIconConstraints,
          suffixIconConstraints: suffixIconConstraints,
          prefix: prefixIcon != null ? AppGaps.wGap16 : null,
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: prefixLeftPaddingSize),
            child: prefixIcon ?? AppGaps.emptyGap,
          ),
          suffix: suffixIcon != null ? AppGaps.wGap16 : null,
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: suffixRightPaddingSize),
            child: suffixIcon ?? AppGaps.emptyGap,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              labelPrefixIcon != null
                  ? Container(
                      alignment: Alignment.topLeft,
                      constraints: const BoxConstraints(minHeight: 10),
                      child: labelPrefixIcon)
                  : AppGaps.emptyGap,
              labelPrefixIcon != null ? AppGaps.wGap15 : AppGaps.emptyGap,
              // Label text
              Expanded(
                child: Row(
                  children: [
                    Text(
                      labelText!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    if (isRequired)
                      Text(
                        ' *',
                        style: AppTextStyles.bodySmallSemiboldTextStyle
                            .copyWith(color: AppColors.errorColor),
                      )
                  ],
                ),
              ),
            ],
          ),
          AppGaps.hGap8,
          // Text field
          textFormFieldWidget(),
        ],
      );
    } else {
      // Text field
      return textFormFieldWidget();
    }
  }
}

class ButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Color color;
  final Color backgroundColor;
  final Widget child;
  final Size? fixedSize;
  final double borderRadiusValue;

  const ButtonWidget({
    Key? key,
    this.onTap,
    this.color = AppColors.primaryColor,
    this.backgroundColor = AppColors.primaryColor,
    required this.child,
    this.fixedSize,
    this.borderRadiusValue = AppConstants.borderRadiusValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: color,
          disabledForegroundColor: AppColors.backgroundColor,
          disabledBackgroundColor: AppColors.secondaryFont2Color,
          backgroundColor: backgroundColor,
          minimumSize: const Size(30, 44),
          fixedSize: fixedSize,
          /*  shape: RoundedRectangleBorder(
              borderRadius:
                  // BorderRadius.all(Radius.circular(Constants.borderRadiusValue)),
                  AppConstants.borderRadius(borderRadiusValue)), */
        ),
        child: child);
  }
}

class CustomSettingsListTileWidget extends StatelessWidget {
  final bool hasShadow;
  final double elevation;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final EdgeInsets paddingValue;
  final BorderRadius borderRadius;
  const CustomSettingsListTileWidget(
      {Key? key,
      required this.child,
      this.onTap,
      this.paddingValue = const EdgeInsets.all(AppGaps.screenPaddingValue),
      this.onLongPress,
      this.borderRadius =
          const BorderRadius.all(AppComponents.defaultBorderRadius),
      this.hasShadow = false,
      this.elevation = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: hasShadow ? elevation : 0,
      shadowColor: Colors.black.withOpacity(0.05),
      borderRadius: borderRadius,
      child: Material(
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            alignment: Alignment.topLeft,
            padding: paddingValue,
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: AppColors.fromBorderColor)),
            child: child,
          ),
        ),
      ),
    );
  }
}

class CustomListTileWidget extends StatelessWidget {
  final bool hasShadow;
  final double elevation;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final EdgeInsets paddingValue;
  final BorderRadius borderRadius;
  const CustomListTileWidget(
      {Key? key,
      required this.child,
      this.onTap,
      this.paddingValue = const EdgeInsets.all(16),
      this.onLongPress,
      this.borderRadius =
          const BorderRadius.all(AppComponents.defaultBorderRadius),
      this.hasShadow = false,
      this.elevation = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: hasShadow ? elevation : 0,
      shadowColor: Colors.black.withOpacity(0.05),
      borderRadius: borderRadius,
      child: Material(
        color: AppColors.fieldbodyColor,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            alignment: Alignment.topLeft,
            padding: paddingValue,
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: AppColors.fromBorderColor)),
            child: child,
          ),
        ),
      ),
    );
  }
}

class CustomPaymentListTileWidget extends StatelessWidget {
  final bool hasShadow;
  final double elevation;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final EdgeInsets paddingValue;
  final BorderRadius borderRadius;
  const CustomPaymentListTileWidget(
      {Key? key,
      required this.child,
      this.onTap,
      this.paddingValue = const EdgeInsets.all(AppGaps.screenPaddingValue),
      this.onLongPress,
      this.borderRadius =
          const BorderRadius.all(AppComponents.defaultBorderRadius),
      this.hasShadow = false,
      this.elevation = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: hasShadow ? elevation : 0,
      shadowColor: Colors.black.withOpacity(0.5),
      borderRadius: borderRadius,
      child: Material(
        color: AppColors.fieldbodyColor,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          onLongPress: onLongPress,
          child:
              child /* Container(
            alignment: Alignment.topLeft,
            padding: paddingValue,
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: AppColors.fromBorderColor)),
            child: child,
          ) */
          ,
        ),
      ),
    );
  }
}

class CustomStretchedOutlinedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final Image? image;
  final Color? backgroundColor;
  final void Function()? onTap;

  const CustomStretchedOutlinedTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
    this.image, // Icon data parameter
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              backgroundColor: backgroundColor,
              minimumSize: const Size(30, 54),
              /* shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(AppComponents.defaultBorderRadius),
              ), */
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (image != null) // Conditionally include the image
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 8.0), // Adjust spacing as needed
                    child: image,
                  ),
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLargeMediumTextStyle
                      .copyWith(color: AppColors.titleTextColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DropdownButtonFieldWidget<T> extends StatelessWidget {
  final Color? labelTextColor;
  final T? value;
  final String hintText;
  final Widget? prefixIcon;
  final bool isLoading;
  final String? labelText;
  final List<T>? items;
  final String Function(T)? getItemText;
  final BoxConstraints prefixIconConstraints;
  final Widget Function(T)? getItemChild;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final TextEditingController? controller;
  final bool isDense;
  final String textButton;
  final void Function()? onAddButtonTap;
  final bool isRequired;
  const DropdownButtonFieldWidget(
      {super.key,
      this.labelTextColor,
      this.value,
      this.textButton = '',
      this.onAddButtonTap,
      required this.hintText,
      this.prefixIcon,
      this.items,
      this.getItemText,
      required this.onChanged,
      this.prefixIconConstraints =
          const BoxConstraints(maxHeight: 48, maxWidth: 48),
      this.labelText,
      this.validator,
      this.controller,
      this.isLoading = false,
      this.getItemChild,
      this.isRequired = false,
      this.isDense = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: isRequired
                      ? Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              labelText!,
                              style: AppTextStyles.labelTextStyle
                                  .copyWith(color: labelTextColor),
                            ),
                            AppGaps.wGap5,
                            Text(
                              '*',
                              style: AppTextStyles.labelTextStyle
                                  .copyWith(color: AppColors.errorColor),
                            ),
                          ],
                        )
                      : Text(
                          labelText!,
                          style: AppTextStyles.labelTextStyle
                              .copyWith(color: labelTextColor),
                        )),
              TextButton(
                  onPressed: onAddButtonTap,
                  child: Text(
                    textButton,
                    style: AppTextStyles.bodyLargeSemiboldTextStyle,
                  ))
            ],
          ),
        if (labelText != null) AppGaps.hGap8,
        Builder(builder: (context) {
          if (isLoading) {
            return const DropdownButtonFormFieldLoadingWidget();
          }
          return DropdownButtonFormField<T>(
            isExpanded: true,
            isDense: isDense,
            dropdownColor: AppColors.shade1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            value: value,
            borderRadius: AppComponents.defaultBorder,
            hint: Text(hintText,
                style: AppTextStyles.labelTextStyle.copyWith(
                  color: AppColors.primaryTextColor,
                )),
            disabledHint: Text(hintText,
                style: AppTextStyles.labelTextStyle.copyWith(
                  color: AppColors.primaryTextColor,
                )),
            icon: SizedBox(
              height: 24,
              width: 24,
              child: SvgPictureAssetWidget(AppAssetImages.arrowDownSVGLogoLine,
                  color: isDisabled()
                      ? AppColors.bodyTextColor.withOpacity(0.5)
                      : AppColors.bodyTextColor),
            ),
            // iconEnabledColor: AppColors.bodyTextColor,
            // iconDisabledColor: AppColors.lineShapeColor,
            decoration: InputDecoration(
                prefixIconConstraints: prefixIconConstraints,
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: prefixIcon,
                      )
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 20)),
            items: items
                ?.map((e) =>
                    DropdownMenuItem(value: e, child: _getItemChildWidget(e)))
                .toList(),
            onChanged: onChanged,
          );
        }),
      ],
    );
  }

  Widget _getItemChildWidget(T element) {
    if (getItemChild != null) {
      return getItemChild!(element);
    }
    if (getItemText != null) {
      return Text(
        getItemText!(element),
        style: TextStyle(
          color: AppColors.primaryTextColor,
        ),
      );
    }
    return AppGaps.emptyGap;
  }

  bool isDisabled() =>
      onChanged == null || (items == null || (items?.isEmpty ?? true));
}

class ScaffoldBodyWidget extends StatelessWidget {
  final Widget child;
  final bool hasNoAppbar;
  const ScaffoldBodyWidget(
      {Key? key, required this.child, this.hasNoAppbar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasNoAppbar
        ? Padding(
            padding: AppComponents.screenHorizontalPadding,
            child: SafeArea(top: true, child: child),
          )
        : Padding(
            padding: AppComponents.screenHorizontalPadding,
            child: child,
          );
  }
}

class CustomPhoneNumberTextFormFieldWidget extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final bool isRequired;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  final CountryCode? initialCountryCode;
  final CountryCode? selectedCountryCode;
  final bool isLabelWhiteText;
  final bool isFilled;
  final Color? fillColor;
  final void Function(CountryCode)? onCountryCodeChanged;
  const CustomPhoneNumberTextFormFieldWidget({
    super.key,
    this.labelText,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.isRequired = false,
    this.initialCountryCode,
    this.selectedCountryCode,
    this.onCountryCodeChanged,
    this.isLabelWhiteText = false,
    this.isFilled = false,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 56,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.shade1,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    border: Border.all(color: AppColors.darkColor)),
                child: CountryCodePicker(
                  initialSelection: initialCountryCode?.code,
                  onChanged: onCountryCodeChanged,
                  builder: (country) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(country?.flagUri ?? '',
                                    package: 'country_code_picker',
                                    fit: BoxFit.cover),
                                AppGaps.wGap10,
                                Expanded(
                                    child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        country?.name ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.bodyMediumTextStyle
                                            .copyWith(
                                                color: AppColors.darkColor),
                                      ),
                                    ),
                                    /* Expanded(
                                      child: Text(
                                        '( ${country?.dialCode ?? ''} )',
                                        style: AppTextStyles.bodyBoldTextStyle
                                            .copyWith(
                                                color:
                                                    AppColors.primaryTextColor),
                                      ),
                                    ), */
                                    AppGaps.wGap30,
                                  ],
                                )),
                                const SvgPictureAssetWidget(
                                    AppAssetImages.arrowDownSVGLogoLine,
                                    color: AppColors.darkColor),
                              ],
                            ),
                          ),
                        ),
                        Container(height: 26),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        CustomPhoneInputTextFormField(
          labelText: labelText,
          prefixIconConstraints: const BoxConstraints(maxHeight: 56),
          suffixIcon: suffixIcon,
          isReadOnly: isReadOnly,
          textInputType: TextInputType.phone,
          suffixIconConstraints: suffixIconConstraints,
          controller: controller,
          validator: validator,
          minLines: minLines,
          maxLines: maxLines,
          onTap: onTap,
          prefixIcon: Text(
            initialCountryCode?.dialCode ?? '',
            style: AppTextStyles.bodyTextStyle
                .copyWith(color: AppColors.bodyTextColor),
          ),
          hintText: hintText,
        ),
        /* TextFormFieldWidget(
          labelText: labelText,
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 32, maxWidth: 147),
          suffixIcon: suffixIcon,
          isPasswordTextField: isPasswordTextField,
          isReadOnly: isReadOnly,
          textInputType: TextInputType.phone,
          suffixIconConstraints: suffixIconConstraints,
          controller: controller,
          validator: validator,
          minLines: minLines,
          maxLines: maxLines,
          fillColor: fillColor,
          isLabelWhiteText: isLabelWhiteText,
          isRequired: isRequired,
          onTap: onTap,
          prefixIcon: Text(
            initialCountryCode?.dialCode ?? '',
            style: AppTextStyles.bodyTextStyle
                .copyWith(color: AppColors.bodyTextColor),
          ),
          hintText: hintText,
        ), */
      ],
    );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomStretcheOutlinedButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomStretcheOutlinedButtonWidget({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                // elevation: 1000,
                // shadowColor: Colors.white,
                foregroundColor: AppColors.primaryColor,
                minimumSize: const Size(30, 62),
                shape: const RoundedRectangleBorder(
                    // side: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
              child: child),
        ),
      ],
    );
  }
}

class CustomPhoneInputTextFormField extends StatelessWidget {
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hasShadow;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  const CustomPhoneInputTextFormField({
    Key? key,
    this.focusNode,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
  }) : super(key: key);

  /// TextField widget
  Widget textFormFieldWidget() {
    return SizedBox(
      // height: 56,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          fillColor: AppColors.shade1,
          filled: true,
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.darkColor),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.darkColor),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18))),
          hintText: hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.darkColor),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18))),
          prefix: AppGaps.wGap10,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 25),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap5,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          // Text field
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      // Text field
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

class CustomScaffoldBodyWidget extends StatelessWidget {
  final Widget child;
  const CustomScaffoldBodyWidget({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppGaps.screenPaddingValue),
      child: child,
    );
  }
}

/* class CenterLoaderWidget extends StatelessWidget {
  const CenterLoaderWidget({
    required this.loading,
    required this.child,
    this.title = 'Loading...',
    super.key,
  });
  final bool loading;
  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Stack(
        children: [
          child,
          const Opacity(
            opacity: 0.3,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
          CustomLoadingDialog(
            title: title,
          ),
        ],
      );
    }
    return child;
  }
} */

class EmptyScreenWidget extends StatelessWidget {
  final String localImageAssetURL;
  final bool isSVGImage;
  final String title;
  final String shortTitle;
  final double height;
  const EmptyScreenWidget({
    Key? key,
    required this.localImageAssetURL,
    required this.title,
    this.shortTitle = '',
    this.isSVGImage = false,
    this.height = 231,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height,
          //  width: 254,
          child: isSVGImage
              ? SvgPicture.asset(localImageAssetURL, height: 231)
              : Image.asset(localImageAssetURL),
        ),
        AppGaps.hGap32,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.titleSemiSmallBoldTextStyle,
              ),
              AppGaps.hGap8,
              Text(shortTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyLargeTextStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final bool isRequired;

  final void Function()? onTap;
  const CustomTextFormField({
    Key? key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 54, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 54, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.focusNode,
    this.isRequired = false,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
  }) : super(key: key);

  /// TextField widget
  Widget textFormFieldWidget() {
    return SizedBox(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        focusNode: focusNode,
        onTap: onTap,
        readOnly: isReadOnly,
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          prefix: AppGaps.wGap24,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap10,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Row(
            children: [
              Text(labelText!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              if (isRequired)
                Text(
                  ' *',
                  style: AppTextStyles.bodySemiboldTextStyle
                      .copyWith(color: AppColors.errorColor),
                )
            ],
          ),
          AppGaps.hGap8,
          // Text field
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      // Text field
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

class CustomPasswordTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final bool isRequired;

  final void Function()? onTap;
  const CustomPasswordTextFormField({
    Key? key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 54, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 54, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.focusNode,
    this.isRequired = false,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
  }) : super(key: key);

  /// TextField widget
  Widget textFormFieldWidget() {
    return SizedBox(
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        focusNode: focusNode,
        onTap: onTap,
        readOnly: isReadOnly,
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          prefix: AppGaps.wGap24,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap10,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Row(
            children: [
              Text(labelText!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              if (isRequired)
                Text(
                  ' *',
                  style: AppTextStyles.bodySemiboldTextStyle
                      .copyWith(color: AppColors.errorColor),
                )
            ],
          ),
          AppGaps.hGap8,
          // Text field
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      // Text field
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

class SelectedLocalImageWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final List<String> imageURLs;
  final List<dynamic> imagesBytes;
  final void Function()? onTap;
  final void Function(int)? onImageEditTap;
  final void Function(int)? onImageDeleteTap;
  final void Function()? onImageUploadTap;

  const SelectedLocalImageWidget({
    super.key,
    required this.label,
    required this.imageURLs,
    this.isRequired = false,
    required this.imagesBytes,
    this.onTap,
    this.onImageEditTap,
    this.onImageDeleteTap,
    this.onImageUploadTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.labelTextStyle,
            ),
            if (isRequired)
              Text(
                ' *',
                style: AppTextStyles.bodySemiboldTextStyle
                    .copyWith(color: AppColors.alertColor),
              )
          ],
        ),
        AppGaps.hGap16,
        SizedBox(
          height: 140,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                // index += 1;
                if (index == imagesBytes.length) {
                  return SizedBox(
                      width: 180,
                      child: SelectImageButton(onTap: onImageUploadTap));
                }
                dynamic singleLocalImage = imagesBytes[index];
/*                 return SizedBox(
                  width: 140,
                  height: 140,
                  child: RawButtonWidget(
                    borderRadiusValue: AppConstants.defaultBorderRadiusValue,
                    onTap: onTap,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: AppComponents.defaultBorder,
                                image: DecorationImage(
                                    image: (singleLocalImage is String)
                                        ? CachedNetworkImageProvider(
                                            singleLocalImage)
                                        : Image.memory(singleLocalImage).image,
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ); */
                return SizedBox(
                  width: 140,
                  child: LocalImageWidget(
                    imagesByte: singleLocalImage,
                    onTap: onTap,
                    showDeleteButton: true,
                    onEditButtonTap: () => onImageEditTap?.call(index),
                    onDeleteButtonTap: () => onImageDeleteTap?.call(index),
                  ),
                );
              }),
              separatorBuilder: (context, index) => AppGaps.wGap10,
              itemCount: imagesBytes.length + 1),
        ),
      ],
    );
  }
}

class LocalImageWidget extends StatelessWidget {
  final Uint8List imagesByte;
  final void Function()? onTap;
  final void Function()? onEditButtonTap;
  final bool showDeleteButton;
  final void Function()? onDeleteButtonTap;
  const LocalImageWidget({
    super.key,
    required this.imagesByte,
    this.onTap,
    this.onEditButtonTap,
    this.onDeleteButtonTap,
    this.showDeleteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 140,
      child: RawButtonWidget(
        borderRadiusValue: AppConstants.defaultBorderRadiusValue,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: AppComponents.defaultBorder,
                    image: DecorationImage(
                        image: Image.memory(imagesByte).image,
                        fit: BoxFit.cover)),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Builder(
                builder: (context) {
                  if (showDeleteButton) {
                    return Row(
                      children: [
                        /* TightIconButtonWidget(
                            icon: const LocalAssetSVGIcon(
                                AppAssetImages.uploadSVGLogoLine,
                                color: Colors.white),
                            onTap: onEditButtonTap), */
                        // AppGaps.wGap8,
                        TightIconButtonWidget(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onTap: onDeleteButtonTap),
                      ],
                    );
                  }
                  return TightIconButtonWidget(
                      icon: const LocalAssetSVGIcon(
                          AppAssetImages.uploadSVGLogoLine,
                          color: Colors.white),
                      onTap: onEditButtonTap);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectImageButton extends StatelessWidget {
  final void Function()? onTap;
  final FocusNode? focusNode;
  const SelectImageButton({
    super.key,
    this.onTap,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return RawButtonWidget(
        borderRadiusValue: AppConstants.uploadImageButtonBorderRadiusValue,
        focusNode: focusNode,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(
                  AppConstants.uploadImageButtonBorderRadiusValue))),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(AppAssetImages.uploadSVGLogoLine,
                  color: AppColors.primaryColor, height: 40),
              AppGaps.hGap2,
              const Text('Tap here to upload images',
                  style: AppTextStyles.bodySemiboldTextStyle),
            ]),
          ),
        ));
  }
}

//multiple image input
class MultiImageUploadSectionWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final List<String> imageURLs;
  final void Function()? onImageUploadTap;
  final void Function(int)? onImageTap;
  final void Function(int)? onImageEditTap;
  final void Function(int)? onImageDeleteTap;
  const MultiImageUploadSectionWidget({
    super.key,
    required this.label,
    this.isRequired = false,
    required this.imageURLs,
    this.onImageUploadTap,
    this.onImageEditTap,
    this.onImageDeleteTap,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.labelTextStyle,
            ),
            if (isRequired)
              Text(
                ' *',
                style: AppTextStyles.bodySemiboldTextStyle
                    .copyWith(color: AppColors.alertColor),
              )
          ],
        ),
        AppGaps.hGap16,
        MultiImageUploadWidget(
          imageURLs: imageURLs,
          onImageTap: onImageTap,
          onImageUploadTap: onImageUploadTap,
          onImageEditTap: onImageEditTap,
          onImageDeleteTap: onImageDeleteTap,
        ),
      ],
    );
  }
}

/// Multiple mixed images (local, uploaded) input
class MultiMixedImageDataUploadSectionWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final List<Object> imageDataList;
  final void Function()? onImageUploadTap;
  final void Function(int)? onImageTap;
  final void Function(int)? onImageEditTap;
  final void Function(int)? onImageDeleteTap;
  final FocusNode? uploadImageButtonFocusNode;
  const MultiMixedImageDataUploadSectionWidget({
    super.key,
    required this.label,
    this.isRequired = false,
    required this.imageDataList,
    this.onImageUploadTap,
    this.onImageEditTap,
    this.onImageDeleteTap,
    this.onImageTap,
    this.uploadImageButtonFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: AppTextStyles.labelTextStyle,
            ),
            if (isRequired)
              Text(
                ' *',
                style: AppTextStyles.bodySemiboldTextStyle
                    .copyWith(color: AppColors.alertColor),
              )
          ],
        ),
        AppGaps.hGap16,
        MultiMixedImageUploadWidget(
          imageDataList: imageDataList,
          uploadImageButtonFocusNode: uploadImageButtonFocusNode,
          onImageTap: onImageTap,
          onImageUploadTap: onImageUploadTap,
          onImageEditTap: onImageEditTap,
          onImageDeleteTap: onImageDeleteTap,
        ),
      ],
    );
  }
}

class MultiImageUploadWidget extends StatelessWidget {
  final List<String> imageURLs;
  final void Function()? onImageUploadTap;
  final void Function(int)? onImageTap;
  final void Function(int)? onImageEditTap;
  final void Function(int)? onImageDeleteTap;
  const MultiImageUploadWidget(
      {super.key,
      required this.imageURLs,
      this.onImageUploadTap,
      this.onImageEditTap,
      this.onImageDeleteTap,
      this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(18))),
      child: Builder(
          builder: (context) => imageURLs.isEmpty
              ? SelectImageButton(onTap: onImageUploadTap)
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == imageURLs.length) {
                      return SizedBox(
                          width: 180,
                          child: SelectImageButton(onTap: onImageUploadTap));
                    }
                    final imageURL = imageURLs[index];
                    return SizedBox(
                      width: 180,
                      child: SelectedNetworkImageWidget(
                        imageURL: imageURL,
                        onTap: onImageTap != null
                            ? () => onImageTap!(index)
                            : null,
                        onEditButtonTap: onImageEditTap != null
                            ? () => onImageEditTap!(index)
                            : null,
                        showDeleteButton: true,
                        onDeleteButtonTap: onImageDeleteTap != null
                            ? () => onImageDeleteTap!(index)
                            : null,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => AppGaps.wGap12,
                  itemCount: imageURLs.length + 1)),
    );
  }
}

class MultiMixedImageUploadWidget extends StatelessWidget {
  final List<Object> imageDataList;
  final FocusNode? uploadImageButtonFocusNode;
  final void Function()? onImageUploadTap;
  final void Function(int)? onImageTap;
  final void Function(int)? onImageEditTap;
  final void Function(int)? onImageDeleteTap;
  const MultiMixedImageUploadWidget(
      {super.key,
      required this.imageDataList,
      this.onImageUploadTap,
      this.onImageEditTap,
      this.onImageDeleteTap,
      this.onImageTap,
      this.uploadImageButtonFocusNode});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(18))),
      child: Builder(
          builder: (context) => imageDataList.isEmpty
              ? SelectImageButton(
                  onTap: onImageUploadTap,
                  focusNode: uploadImageButtonFocusNode)
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == imageDataList.length) {
                      return SizedBox(
                          width: 180,
                          child: SelectImageButton(onTap: onImageUploadTap));
                    }
                    final imageData = imageDataList[index];
                    return SizedBox(
                      width: 180,
                      child: SelectedMixedImageDataWidget(
                        imageData: imageData,
                        onTap: onImageTap != null
                            ? () => onImageTap!(index)
                            : null,
                        onEditButtonTap: onImageEditTap != null
                            ? () => onImageEditTap!(index)
                            : null,
                        showDeleteButton: true,
                        onDeleteButtonTap: onImageDeleteTap != null
                            ? () => onImageDeleteTap!(index)
                            : null,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => AppGaps.wGap12,
                  itemCount: imageDataList.length + 1)),
    );
  }
}

class MultiLocalNetworkImageUploadWidget extends StatelessWidget {
  final List<String> imageURLs;
  final void Function()? onImageUploadTap;
  final void Function(int)? onImageTap;
  final void Function(int)? onImageEditTap;
  final void Function(int)? onImageDeleteTap;
  const MultiLocalNetworkImageUploadWidget(
      {super.key,
      required this.imageURLs,
      this.onImageUploadTap,
      this.onImageEditTap,
      this.onImageDeleteTap,
      this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 126,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(18))),
      child: Builder(
          builder: (context) => imageURLs.isEmpty
              ? SelectImageButton(onTap: onImageUploadTap)
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == imageURLs.length) {
                      return SizedBox(
                          width: 180,
                          child: SelectImageButton(onTap: onImageUploadTap));
                    }
                    final imageURL = imageURLs[index];
                    return SizedBox(
                      width: 180,
                      child: SelectedNetworkImageWidget(
                        imageURL: imageURL,
                        onTap: onImageTap != null
                            ? () => onImageTap!(index)
                            : null,
                        onEditButtonTap: onImageEditTap != null
                            ? () => onImageEditTap!(index)
                            : null,
                        showDeleteButton: true,
                        onDeleteButtonTap: onImageDeleteTap != null
                            ? () => onImageDeleteTap!(index)
                            : null,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => AppGaps.wGap12,
                  itemCount: imageURLs.length + 1)),
    );
  }
}

class SelectedNetworkImageWidget extends StatelessWidget {
  final String imageURL;
  final void Function()? onTap;
  final void Function()? onEditButtonTap;
  final bool showDeleteButton;
  final void Function()? onDeleteButtonTap;

  const SelectedNetworkImageWidget({
    super.key,
    required this.imageURL,
    this.onTap,
    this.onEditButtonTap,
    this.onDeleteButtonTap,
    this.showDeleteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 140,
      child: RawButtonWidget(
        borderRadiusValue: AppConstants.defaultBorderRadiusValue,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned.fill(
              child: CachedNetworkImageWidget(
                imageURL: imageURL,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: AppComponents.defaultBorder,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Builder(
                builder: (context) {
                  if (showDeleteButton) {
                    return Row(
                      children: [
                        /* TightIconButtonWidget(
                            icon: const LocalAssetSVGIcon(
                                AppAssetImages.uploadSVGLogoLine,
                                color: Colors.white),
                            onTap: onEditButtonTap), */
                        // AppGaps.wGap8,
                        TightIconButtonWidget(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onTap: onDeleteButtonTap),
                      ],
                    );
                  }
                  return TightIconButtonWidget(
                      icon: const LocalAssetSVGIcon(
                          AppAssetImages.uploadSVGLogoLine,
                          color: Colors.white),
                      onTap: onEditButtonTap);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectedMixedImageDataWidget extends StatelessWidget {
  final dynamic imageData;
  final void Function()? onTap;
  final void Function()? onEditButtonTap;
  final bool showDeleteButton;
  final void Function()? onDeleteButtonTap;

  const SelectedMixedImageDataWidget({
    super.key,
    required this.imageData,
    this.onTap,
    this.onEditButtonTap,
    this.onDeleteButtonTap,
    this.showDeleteButton = false,
  });

  @override
  Widget build(BuildContext context) {
    if (imageData is String) {
      return SelectedNetworkImageWidget(
        imageURL: imageData,
        onTap: onTap != null ? () => onTap?.call() : null,
        onEditButtonTap:
            onEditButtonTap != null ? () => onEditButtonTap?.call() : null,
        showDeleteButton: showDeleteButton,
        onDeleteButtonTap:
            onDeleteButtonTap != null ? () => onDeleteButtonTap?.call() : null,
      );
    }
    if (imageData is Uint8List) {
      return LocalImageWidget(
        imagesByte: imageData,
        onTap: onTap != null ? () => onTap?.call() : null,
        onEditButtonTap:
            onEditButtonTap != null ? () => onEditButtonTap?.call() : null,
        showDeleteButton: showDeleteButton,
        onDeleteButtonTap:
            onDeleteButtonTap != null ? () => onDeleteButtonTap?.call() : null,
      );
    }
    return SizedBox(
      child: RawButtonWidget(
        borderRadiusValue: AppConstants.defaultBorderRadiusValue,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: AppComponents.defaultBorder),
                child: const Center(child: Text('Unknown image type')),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Builder(
                builder: (context) {
                  if (showDeleteButton) {
                    return Row(
                      children: [
                        /* TightIconButtonWidget(
                            icon: const LocalAssetSVGIcon(
                                AppAssetImages.uploadSVGLogoLine,
                                color: Colors.white),
                            onTap: onEditButtonTap), */
                        // AppGaps.wGap8,
                        TightIconButtonWidget(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onTap: onDeleteButtonTap),
                      ],
                    );
                  }
                  return TightIconButtonWidget(
                      icon: const LocalAssetSVGIcon(
                          AppAssetImages.uploadSVGLogoLine,
                          color: Colors.white),
                      onTap: onEditButtonTap);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomMessageTextFormField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isReadOnly;
  final double boxHeight;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? minLines;
  final int maxLines;
  final void Function()? onTap;
  const CustomMessageTextFormField({
    Key? key,
    this.labelText,
    this.boxHeight = 62,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
  }) : super(key: key);

  /// TextField widget
  Widget textFormFieldWidget() {
    return SizedBox(
      // height: (maxLines > 1 || (minLines ?? 1) > 1) ? null : boxHeight,
      child: TextFormField(
        controller: controller,
        onTap: onTap,
        readOnly: isReadOnly,
        obscureText: isPasswordTextField,
        keyboardType: textInputType,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              borderSide:
                  BorderSide(color: AppColors.fromBorderColor, width: 1)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
              borderSide:
                  BorderSide(color: AppColors.fromBorderColor, width: 1)),
          hintText: hintText,
          prefix: AppGaps.wGap10,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: prefixIcon,
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          suffixIconConstraints: suffixIconConstraints,
          suffix: AppGaps.wGap10,
          suffixIcon: suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: suffixIcon,
                )
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    if (labelText != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label text
          Text(labelText!,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          AppGaps.hGap8,
          // Text field
          hasShadow
              ? PhysicalModel(
                  color: Colors.transparent,
                  elevation: 10,
                  shadowColor: Colors.black.withOpacity(0.25),
                  child: textFormFieldWidget(),
                )
              : textFormFieldWidget(),
        ],
      );
    } else {
      // Text field
      return hasShadow
          ? PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black.withOpacity(0.25),
              child: textFormFieldWidget())
          : textFormFieldWidget();
    }
  }
}

class CustomMessageListTileWidget extends StatelessWidget {
  final bool hasShadow;
  final double elevation;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final EdgeInsets paddingValue;
  final BorderRadius borderRadius;
  const CustomMessageListTileWidget(
      {Key? key,
      required this.child,
      this.onTap,
      this.paddingValue =
          const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      this.onLongPress,
      this.borderRadius =
          const BorderRadius.all(AppComponents.defaultBorderRadius),
      this.hasShadow = false,
      this.elevation = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: hasShadow ? elevation : 0,
      shadowColor: Colors.grey.withOpacity(0.9),
      borderRadius: borderRadius,
      child: Material(
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            alignment: Alignment.topLeft,
            padding: paddingValue,
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: AppColors.fromBorderColor, width: 1)),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// This icon button does not have any padding, margin around it
class TightIconButtonWidget extends StatelessWidget {
  final Widget icon;
  final Function()? onTap;
  const TightIconButtonWidget({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.zero,
        visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: VisualDensity.minimumDensity),
        onPressed: onTap,
        icon: icon);
  }
}

class CustomStretchedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final bool isLoading;
  final void Function()? onTap;
  const CustomStretchedTextButtonWidget({
    Key? key,
    this.onTap,
    required this.buttonText,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 54,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  gradient: onTap == null
                      ? LinearGradient(colors: [
                          Color.lerp(AppColors.packageTextGreyColor,
                                  Colors.white, 0.5) ??
                              AppColors.packageTextGreyColor.withOpacity(0.5),
                          Color.lerp(AppColors.packageTextGreyColor,
                                  Colors.white, 0.5) ??
                              AppColors.packageTextGreyColor
                        ])
                      : LinearGradient(colors: [
                          AppColors.primaryColor,
                          Color.lerp(
                                  AppColors.primaryColor, Colors.white, 0.1) ??
                              AppColors.primaryColor.withOpacity(0.4),
                        ])),
              child: TextButton(
                  onPressed: onTap,
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      elevation: onTap == null ? 0 : 10,
                      shadowColor: AppColors.primaryColor.withOpacity(0.25),
                      // backgroundColor: onTap == null
                      //     ? AppColors.primaryColor.withOpacity(0.15)
                      //     : AppColors.primaryColor.withOpacity(0.0),
                      minimumSize: const Size(15, 30),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              AppComponents.defaultBorderRadius))),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(buttonText,
                          textAlign: TextAlign.center,
                          style: onTap == null
                              ? AppTextStyles.bodyLargeSemiboldTextStyle
                                  .copyWith(
                                      color: AppColors.packageTextGreyColor)
                              : null)),
            ),
          ),
        ),
      ],
    );
  }
}

class SvgPictureAssetWidget extends StatelessWidget {
  final String assetName;
  final double? height;
  final double? width;
  final Color? color;
  final String? package;
  final BoxFit fit;
  const SvgPictureAssetWidget(this.assetName,
      {super.key,
      this.height,
      this.width,
      this.color,
      this.package,
      this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(assetName,
        height: height,
        width: width,
        fit: fit,
        colorFilter: color == null
            ? const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn)
            : ColorFilter.mode(color!, BlendMode.srcIn));
  }
}

/// Radio widget without additional padding
class CustomRadioWidget extends StatelessWidget {
  final Object value;
  final Object? groupValue;
  final Function(Object?) onChanged;
  const CustomRadioWidget(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: Radio<Object>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}

/*<-------Custom dialog button widget-------->*/
class CustomDialogButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  const CustomDialogButtonWidget({
    Key? key,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            elevation: 10,
            shadowColor: AppColors.primaryColor.withOpacity(0.25),
            backgroundColor: onTap == null
                ? AppColors.bodyTextColor
                : AppColors.primaryColor,
            minimumSize: const Size(128, 33),
            shape: const StadiumBorder()),
        child: child);
  }
}

/*<------- Custom TextButton stretches the width of the screen with small elevation ------>*/
class CustomStretchedOutlinedButtonWidget extends StatelessWidget {
  final Color bordercolor;
  final Widget child;
  final void Function()? onTap;
  const CustomStretchedOutlinedButtonWidget({
    Key? key,
    required this.bordercolor,
    this.onTap,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.backgroundColor,
                foregroundColor: AppColors.backgroundColor,
                minimumSize: const Size(30, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(2.0)),
                  side: BorderSide(width: 5.0, color: AppColors.primaryColor),
                ),
              ),
              child: child),
        ),
      ],
    );
  }
}

/*<------- ExpansionTile widget ------>*/
class ExpansionTileWidget extends StatelessWidget {
  final Widget titleWidget;
  final List<Widget> children;

  const ExpansionTileWidget({
    Key? key,
    required this.titleWidget,
    required this.children,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.bodyTextColor),
            borderRadius: BorderRadius.circular(4)),
        child: ExpansionTile(
          title: titleWidget,
          children: children,
        ));
  }
}

class CustomScaffoldBottomBarWidget extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  const CustomScaffoldBottomBarWidget(
      {super.key,
      required this.child,
      this.backgroundColor,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppGaps.bottomNavBarPadding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class CustomTightTextButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  const CustomTightTextButtonWidget({
    super.key,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity)),
        child: child);
  }
}

class HorizontalLine extends StatelessWidget {
  final Color? color;
  final Color? textcolor;
  final String text;
  const HorizontalLine({
    Key? key,
    this.color,
    required this.textcolor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppGaps.hGap5,
        Container(
          height: 5,
          width: MediaQuery.of(context).size.width * 0.43,
          color: color ?? AppColors.primaryColor.withOpacity(0.5),
        ),
        AppGaps.hGap5,
        Text(text,
            style:
                AppTextStyles.bodyMediumTextStyle.copyWith(color: textcolor)),
      ],
    );
  }
}

class EnrollPaymentButtonLoadingWidget extends StatelessWidget {
  const EnrollPaymentButtonLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: StretchedTextButtonWidget(buttonText: 'Loading'),
    );
  }
}

class LoadingPlaceholderWidget extends StatelessWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  const LoadingPlaceholderWidget({
    super.key,
    required this.child,
    this.baseColor = AppColors.shimmerBaseColor,
    this.highlightColor = AppColors.shimmerHighlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: baseColor, highlightColor: highlightColor, child: child);
  }
}

class LoadingStretchedTextButtonWidget extends StatelessWidget {
  final String buttonText;
  const LoadingStretchedTextButtonWidget({
    super.key,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: Row(
        children: [
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  // color: AppColors.primaryColor.withOpacity(0.5),
                  gradient: LinearGradient(colors: [
                    AppColors.primaryColor.withOpacity(0.5),
                    AppColors.primaryColor.withOpacity(0.5)
                  ])),
              child: TextButton(
                  onPressed: null,
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: AppColors.primaryColor.withOpacity(0.25),
                      // backgroundColor: onTap == null
                      //     ? AppColors.primaryColor.withOpacity(0.15)
                      //     : AppColors.primaryColor.withOpacity(0.0),
                      minimumSize: const Size(30, 62),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              AppComponents.defaultBorderRadius))),
                  child: Text(buttonText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white))),
            ),
          ),
        ],
      ),
    );
  }
}

/* <-------- Notification Dot Widget -------> */
class NotificationDotWidget extends StatelessWidget {
  final bool isRead;
  const NotificationDotWidget({super.key, this.isRead = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: isRead
              ? AppColors.primaryButtonColor.withOpacity(0.1)
              : AppColors.errorColor,
          shape: BoxShape.circle),
    );
  }
}

/*<--------Custom app bar widget------->*/
class CoreWidgets {
  static AppBar appBarWidget({
    required BuildContext screenContext,
    Color? appBarBackgroundColor,
    Widget? titleWidget,
    String? titleText,
    TextStyle? titleTextStyle,
    List<Widget>? actions,
    Widget? leading,
    bool hasBackButton = false,
    bool automaticallyImplyLeading = false,
    void Function()? onLeadingPressed,
  }) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      leading: hasBackButton
          ? Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 0.0),
              child: Center(
                child: Container(
                  height: 35,
                  width: 44,
                  decoration: BoxDecoration(color: AppColors.fieldbodyColor),
                  child: RawButtonWidget(
                    onTap: onLeadingPressed ?? () => Get.back(),
                    child: const Center(
                      child: SvgPictureAssetWidget(
                        AppAssetImages.arrowLeftSVGLogoLine,
                        color: AppColors.titleTextColor,
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20),
              child: leading,
            ),
      title: Text(
        titleText ?? '',
        style: titleTextStyle ?? AppTextStyles.semiSmallXBoldTextStyle,
      ),
      actions: actions,
    );
  }

  static PagedChildBuilderDelegate<ItemType>
      pagedChildBuilderDelegate<ItemType>({
    required Widget Function(BuildContext, ItemType, int) itemBuilder,
    Widget Function(BuildContext)? errorIndicatorBuilder,
    Widget Function(BuildContext)? noItemFoundIndicatorBuilder,
    Widget Function(BuildContext)? firstPageLoadingIndicatorBuilder,
    Widget Function(BuildContext)? newPageLoadingIndicatorBuilder,
  }) {
    final firstPageProgressIndicatorBuilder =
        firstPageLoadingIndicatorBuilder ??
            (context) => const Center(child: CircularProgressIndicator());
    final newPageProgressIndicatorBuilder = newPageLoadingIndicatorBuilder ??
        (context) => const Center(child: CircularProgressIndicator());
    final pageErrorIndicatorBuilder =
        errorIndicatorBuilder ?? (context) => const ErrorPaginationWidget();
    final noItemsFoundIndicatorBuilder = noItemFoundIndicatorBuilder ??
        (context) => const ErrorPaginationWidget();
    return PagedChildBuilderDelegate<ItemType>(
        itemBuilder: itemBuilder,
        firstPageErrorIndicatorBuilder: pageErrorIndicatorBuilder,
        newPageErrorIndicatorBuilder: pageErrorIndicatorBuilder,
        noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
        firstPageProgressIndicatorBuilder: firstPageProgressIndicatorBuilder,
        newPageProgressIndicatorBuilder: newPageProgressIndicatorBuilder,
        animateTransitions: true,
        transitionDuration: const Duration(milliseconds: 200));
  }
}

/* <-------- Error Pagination Widget -------> */
class ErrorPaginationWidget extends StatelessWidget {
  final String errorMessage;
  const ErrorPaginationWidget({
    Key? key,
    this.errorMessage = 'Error occurred while loading',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 150,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ErrorLoadedIconWidget(isLargeIcon: true),
            AppGaps.hGap5,
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMediumTextStyle,
            ),
          ],
        ));
  }
}

class DropdownButtonFormFieldWidget<T> extends StatelessWidget {
  final T? value;
  final bool isRequired;
  final String hintText;
  final Widget? prefixIcon;
  final bool isLoading;
  final String? labelText;
  final Color? labelTextColor;
  final List<T>? items;
  final String Function(T)? getItemText;
  final String Function(int index, T item)? getItemTextIndex;
  final BoxConstraints prefixIconConstraints;
  final Widget Function(int index, T item)? getItemChild;
  final void Function(T? item)? onChanged;
  final String? Function(T? item)? validator;
  final TextEditingController? controller;
  final bool isDense;
  final String textButton;
  final void Function()? onAddButtonTap;
  final void Function()? onTap;
  const DropdownButtonFormFieldWidget(
      {super.key,
      this.textButton = '',
      this.labelTextColor,
      this.onAddButtonTap,
      this.value,
      required this.hintText,
      this.prefixIcon,
      this.items,
      this.getItemText,
      this.getItemTextIndex,
      required this.onChanged,
      this.prefixIconConstraints =
          const BoxConstraints(maxHeight: 54, maxWidth: 48),
      this.labelText,
      this.validator,
      this.controller,
      this.isLoading = false,
      this.isRequired = false,
      this.getItemChild,
      this.isDense = true,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Row(
            children: [
              Text(labelText!,
                  style: AppTextStyles.bodyLargeMediumTextStyle
                      .copyWith(color: AppColors.darkColor)),
              if (isRequired)
                Text(
                  ' *',
                  style: AppTextStyles.bodySemiboldTextStyle
                      .copyWith(color: AppColors.alertColor),
                )
            ],
          ),
        /* Text(
            labelText!,
            style: AppTextStyles.labelTextStyle.copyWith(color: labelTextColor),
          ),
            style: AppTextStyles.labelTextStyle
                .copyWith(color: AppColors.darkColor),
          ), */
        if (labelText != null) AppGaps.hGap8,
        Builder(builder: (context) {
          if (isLoading) {
            return const DropdownButtonFormFieldLoadingWidget();
          }
          return DropdownButtonFormField<T>(
            dropdownColor: AppColors.backgroundColor,
            style: AppTextStyles.bodyLargeMediumTextStyle
                .copyWith(color: AppColors.darkColor),
            isExpanded: true,
            onTap: onTap,
            isDense: isDense,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            value: value,

            borderRadius: AppComponents.defaultBorder,
            hint: Text(
              hintText,
              style: AppTextStyles.bodyLargeTextStyle
                  .copyWith(color: AppColors.darkColor),
            ),
            disabledHint: Text(hintText,
                style: AppTextStyles.labelTextStyle
                    .copyWith(color: AppColors.darkColor)),
            icon: /* LocalAssetSVGIcon(AppAssetImages.dropdownArrow,
                color: isDisabled()
                    ? AppColors.bodyTextColor.withOpacity(0.5)
                    : AppColors.bodyTextColor) */
                Icon(Icons.keyboard_arrow_down,
                    color: isDisabled()
                        ? AppColors.bodyTextColor.withOpacity(0.5)
                        : AppColors.bodyTextColor),
            // iconEnabledColor: AppColors.bodyTextColor,
            // iconDisabledColor: AppColors.lineShapeColor,
            decoration: InputDecoration(
                prefixIconConstraints: prefixIconConstraints,
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: prefixIcon,
                      )
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 18)),
            items: items
                ?.mapIndexed((i, e) => DropdownMenuItem(
                    value: e, child: _getItemChildWidget(i, e)))
                .toList(),
            onChanged: onChanged,
          );
        }),
      ],
    );
  }

  Widget _getItemChildWidget(int index, T element) {
    if (getItemChild != null) {
      return getItemChild!(index, element);
    }
    if (getItemTextIndex != null) {
      return Text(getItemTextIndex!(index, element),
          style: AppTextStyles.bodyLargeMediumTextStyle
              .copyWith(color: AppColors.darkColor));
    }
    return AppGaps.emptyGap;
  }

  bool isDisabled() =>
      onChanged == null || (items == null || (items?.isEmpty ?? true));
}

class DropdownButtonFormFieldLoadingWidget extends StatelessWidget {
  const DropdownButtonFormFieldLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      child: Container(
        height: 50,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: AppComponents.defaultBorder,
            border: Border.all(width: 2)),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 120, child: LoadingTextWidget()),
              Spacer(),
              LocalAssetSVGIcon(AppAssetImages.arrowDownSVGLogoLine,
                  color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}

class LocalAssetSVGIcon extends StatelessWidget {
  final String iconLocalAssetLocation;
  final Color color;
  final double height;
  final double? width;
  const LocalAssetSVGIcon(this.iconLocalAssetLocation,
      {Key? key, required, required this.color, this.height = 24, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(iconLocalAssetLocation,
        height: height,
        width: width ?? height,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
  }
}

class LoadingTextWidget extends StatelessWidget {
  final bool isSmall;
  const LoadingTextWidget({
    super.key,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isSmall ? 15 : 20,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white, borderRadius: AppComponents.smallBorderRadius),
      ),
    );
  }
}

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageURL;
  final BoxFit boxFit;
  final int? cacheHeight;
  final int? cacheWidth;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  const CachedNetworkImageWidget({
    Key? key,
    required this.imageURL,
    this.boxFit = BoxFit.cover,
    this.cacheHeight,
    this.cacheWidth,
    this.imageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageURL.isEmpty
        ? Image.asset(AppAssetImages.imagePlaceholderIconImage,
            fit: BoxFit.contain)
        : CachedNetworkImage(
            imageUrl: imageURL,
            placeholder: (context, url) =>
                const LoadingImagePlaceholderWidget(),
            errorWidget: (context, url, error) => const ErrorLoadedIconWidget(),
            imageBuilder: imageBuilder,
            memCacheHeight: cacheHeight,
            memCacheWidth: cacheWidth,
            fit: boxFit);
  }
}

/// Raw list tile does not have a background color
class CustomRawListTileWidget extends StatelessWidget {
  final Widget child;
  final bool isRead;
  final void Function()? onTap;
  final Radius? borderRadiusRadiusValue;
  const CustomRawListTileWidget({
    super.key,
    required this.child,
    this.isRead = true,
    this.onTap,
    this.borderRadiusRadiusValue,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isRead ? Colors.transparent : Colors.grey.withOpacity(0.1),
      borderRadius: borderRadiusRadiusValue != null
          ? BorderRadius.all(borderRadiusRadiusValue!)
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadiusRadiusValue != null
            ? BorderRadius.all(borderRadiusRadiusValue!)
            : null,
        child: child,
      ),
    );
  }
}

class DottedHorizontalLine extends StatelessWidget {
  final Color? dashColor;
  final double dashLength;
  final double dashGapLength;
  const DottedHorizontalLine({
    Key? key,
    this.dashColor,
    this.dashLength = 4,
    this.dashGapLength = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedLine(
      lineThickness: 1.5,
      dashColor: dashColor ?? AppColors.primaryColor.withOpacity(0.5),
      dashLength: dashLength,
      dashGapLength: dashGapLength,
      dashRadius: 50,
    );
  }
}

/// Custom IconButton widget various attributes
class CustomIconButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  final Border? border;
  final Widget child;
  final Color backgroundColor;
  final Size fixedSize;
  final Radius borderRadiusRadiusValue;
  final bool isCircleShape;
  final bool hasShadow;
  const CustomIconButtonWidget(
      {Key? key,
      this.onTap,
      required this.child,
      this.backgroundColor = AppColors.primary50Color,
      this.fixedSize = const Size(40, 40),
      this.borderRadiusRadiusValue = const Radius.circular(14),
      this.border,
      this.isCircleShape = false,
      this.hasShadow = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fixedSize.height,
      width: fixedSize.width,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          shape: isCircleShape ? BoxShape.circle : BoxShape.rectangle,
          borderRadius:
              isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
          border: border),
      child: Material(
        color: backgroundColor,
        shape: isCircleShape ? const CircleBorder() : null,
        shadowColor: hasShadow ? Colors.black.withOpacity(0.4) : null,
        elevation: hasShadow ? 8 : 0,
        borderRadius:
            isCircleShape ? null : BorderRadius.all(borderRadiusRadiusValue),
        child: InkWell(
          onTap: onTap,
          customBorder: isCircleShape ? const CircleBorder() : null,
          borderRadius: BorderRadius.all(borderRadiusRadiusValue),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class ErrorLoadedIconWidget extends StatelessWidget {
  final bool isLargeIcon;
  const ErrorLoadedIconWidget({
    Key? key,
    this.isLargeIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Icon(Icons.error_outline,
            size: isLargeIcon ? 40 : null, color: AppColors.alertColor));
  }
}

class LoadingImagePlaceholderWidget extends StatelessWidget {
  final double? height;
  final double? width;
  const LoadingImagePlaceholderWidget({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: LoadingPlaceholderWidget(
          child: Image.asset(AppAssetImages.imagePlaceholderIconImage)),
    );
  }
}

class NoImageAvatarWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  const NoImageAvatarWidget({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: AppColors.primaryColor, shape: BoxShape.circle),
      child: Text(
        Helper.avatar2LetterUsername(firstName, lastName),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class RawButtonWidget extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final double? borderRadiusValue;
  final Color? backgroundColor;
  final FocusNode? focusNode;

  const RawButtonWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.borderRadiusValue,
    this.backgroundColor,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: borderRadiusValue != null
          ? BorderRadius.all(Radius.circular(borderRadiusValue!))
          : null,
      child: InkWell(
        onTap: onTap,
        focusNode: focusNode,
        borderRadius: borderRadiusValue != null
            ? BorderRadius.all(Radius.circular(borderRadiusValue!))
            : null,
        child: child,
      ),
    );
  }
}

/// Custom TextButton stretches the width of the screen with small elevation
/// shadow with custom child widget
class CustomStretchedOnlyTextButtonWidget extends StatelessWidget {
  final String buttonText;
  final void Function()? onTap;
  const CustomStretchedOnlyTextButtonWidget({
    super.key,
    this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                  minimumSize: const Size(30, 32),
                  visualDensity: const VisualDensity(),
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.all(AppComponents.defaultBorderRadius))),
              child: Text(
                buttonText,
                style: AppTextStyles.bodyLargeSemiboldTextStyle
                    .copyWith(color: AppColors.darkColor),
              )),
        ),
      ],
    );
  }
}

class AlertDialogWidget extends StatelessWidget {
  final List<Widget>? actionWidgets;
  final Widget? contentWidget;
  final Widget? titleWidget;
  final Color? backgroundColor;
  const AlertDialogWidget({
    super.key,
    this.actionWidgets,
    this.contentWidget,
    this.titleWidget,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      titlePadding: AppComponents.dialogTitlePadding,
      contentPadding: AppComponents.dialogContentPadding,
      shape: const RoundedRectangleBorder(
          borderRadius: AppComponents.dialogBorderRadius),
      title: titleWidget,
      content: contentWidget,
      actions: actionWidgets,
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: AppComponents.dialogActionPadding,
      buttonPadding: EdgeInsets.zero,
    );
  }
}
