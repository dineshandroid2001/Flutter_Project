// ignore_for_file: must_be_immutable

import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  double paddingValue;
  double topLeftValue;
  double topRightValue;
  double bottomLeftValue;
  double bottomRightValue;
  final Color colors;
  final Widget? child;
  ContainerWidget(
      {super.key,
      this.paddingValue = 0.0,
      this.topLeftValue = 0.0,
      this.topRightValue = 0.0,
      this.bottomLeftValue = 0.0,
      this.bottomRightValue = 0.0,
      this.colors = AppConstants.primaryColor, 
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(paddingValue),
      width: bottomLeftValue == 0 ? double.infinity :null,
      decoration: topLeftValue != 0.0
          ? BoxDecoration(
            color: colors,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeftValue),
                topRight: Radius.circular(topRightValue),
                bottomLeft: Radius.circular(bottomLeftValue),
                bottomRight: Radius.circular(bottomRightValue)
              ),
            )
          : null,
      child: child,
    );
  }
}
