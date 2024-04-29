// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SizedBoxWidget extends StatelessWidget {
  double height;
  double width;
  final Widget? child;
  
  SizedBoxWidget({
    super.key, 
    this.height = 0.0, 
    this.width = 0.0, 
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height > 0.0 ? MediaQuery.of(context).size.height * height : null,
      width: width > 0.0 ? MediaQuery.of(context).size.width * width : null,
      child: child,
    );
  }
}
