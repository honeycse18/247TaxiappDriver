import 'package:flutter/material.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

/// Per intro page content widget
class IntroImageContentWidget extends StatelessWidget {
  final String localImageLocation;
  const IntroImageContentWidget({
    Key? key,
    required this.localImageLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      localImageLocation,
      fit: BoxFit.cover,
    );
  }
}

class IntroSloganContentWidget extends StatelessWidget {
  final String slogan;
  final String subtitle;
  const IntroSloganContentWidget({
    Key? key,
    required this.slogan,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrolightAndDetailTextWidget(slogan: slogan, subtitle: subtitle);
  }
}
