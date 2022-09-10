import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CardContainerWidget extends StatelessWidget {
  const CardContainerWidget({
    Key? key,
    required this.child,
    required this.height,
    this.padding = const EdgeInsets.symmetric(
      horizontal: 15,
    ),
  }) : super(key: key);

  final Widget child;
  final double height;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).brightness == Brightness.dark
            ? HexColor("#171717")
            : HexColor("#8EBCEE"),
      ),
      child: child,
    );
  }
}
