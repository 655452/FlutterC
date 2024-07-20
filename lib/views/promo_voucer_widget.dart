import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/global-controller.dart';
import '../../utils/theme_colors.dart';
import '../models/restaurant_details.dart';

// ignore: must_be_immutable
class PromoText extends StatelessWidget {
  PromoText({
    Key? key,
    required this.voucher,
  }) : super(key: key);

  Vouchers voucher;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 5),
      height: 80,
      width: double.infinity,
      color: ThemeColors.baseThemeColor.withOpacity(0.06),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'VOUCHER : ',
                style: textTheme.bodyLarge?.copyWith(fontSize: 16),
              ),
              Text(
                voucher.slug.toString(),
                style: TextStyle(
                  color: ThemeColors.baseThemeColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Use voucher ${voucher.slug.toString()} and get ${voucher.amount.toString()} ${Get.find<GlobalController>().currencyCode.toString()}  off on orders over ${voucher.minimumOrderAmount.toString()} ${Get.find<GlobalController>().currencyCode.toString()} ',
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
}
