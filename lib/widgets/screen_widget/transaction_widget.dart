// /* <---- Transaction widget ----> */

// class TransactionWidget extends StatelessWidget {
//   final String text1;
//   final String text2;

//   final Widget icon;
//   final Color backColor;
//   final String title;
//   final DateTime dateTime;

//   const TransactionWidget(
//       {Key? key,
//       required this.title,
//       required this.text1,
//       required this.text2,
//       required this.icon,
//       required this.backColor,
//       required this.dateTime})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//       Row(children: [
//         CircleAvatar(maxRadius: 16, backgroundColor: backColor, child: icon),
//         AppGaps.wGap10,
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(title,
//                 style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: Color.fromARGB(255, 12, 1, 59))),
//             Text(
//               dayText,
//               style: AppTextStyles.captionTextStyle,
//             ),
//           ],
//         ),
//       ]),
//       Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(text2,
//               style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                   color: Color.fromARGB(255, 12, 1, 59))),
//           Text(text1,
//               style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                   color: Colors.grey)),
//         ],
//       ),
//     ]);
//   }

//   String get dayText {
//     if (Helper.isToday(dateTime)) {
//       return 'Today';
//     }
//     if (Helper.wasYesterday(dateTime)) {
//       return 'Yesterday';
//     }
//     if (Helper.isTomorrow(dateTime)) {
//       return 'Tomorrow';
//     }
//     return Helper.ddMMMyyyyFormattedDateTime(dateTime);
//   }
// }

/* <---- Transaction widget ----> */

import 'package:flutter/material.dart';
import 'package:taxiappdriver/utils/constansts/app_colors.dart';
import 'package:taxiappdriver/utils/constansts/app_gaps.dart';
import 'package:taxiappdriver/utils/constansts/app_images.dart';
import 'package:taxiappdriver/utils/constansts/app_text_style.dart';
import 'package:taxiappdriver/widgets/screen_widget/core_widget.dart';

class TransactionWidget extends StatelessWidget {
  final String amountText;
  final String type;
  final Color color;
  final Color backColor;

  final String dayText;

  final String title;

  const TransactionWidget({
    Key? key,
    required this.title,
    required this.type,
    required this.amountText,
    required this.color,
    required this.backColor,
    required this.dayText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(children: [
        Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(color: AppColors.fieldbodyColor),
            child: type == 'add_money'
                ? const Center(
                    child: SvgPictureAssetWidget(
                        AppAssetImages.topUpSVGLogoSolid,
                        color: AppColors.topUpIconColor),
                  )
                : const Center(
                    child: SvgPictureAssetWidget(
                        AppAssetImages.withdrawSVGLogoSolid,
                        color: AppColors.withdrawIconColor),
                  )),
        AppGaps.wGap10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color.fromARGB(255, 12, 1, 59))),
            Text(
              dayText,
              style: AppTextStyles.captionTextStyle,
            ),
          ],
        ),
      ]),
      Container(
        height: 34,
        width: 93,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(color: color.withOpacity(0.1)),
        child: Text(amountText,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: color)),
      ),
    ]);
  }
}
