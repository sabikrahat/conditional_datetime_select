import 'package:flutter/material.dart';

class DesignButton extends StatelessWidget {
  const DesignButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.color = Colors.white,
    required this.width,
    required this.height,
    this.borderColor = Colors.blue,
    this.borderAngel = 32.0,
  }) : super(key: key);
  final Function()? onPressed;
  final Widget child;
  final Color color;
  final Color borderColor;
  final double height;
  final double width;
  final double borderAngel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: height > 50 ? 50 : height,
          width: width,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: borderColor,
              width: 2.5,
            ),
            borderRadius: BorderRadius.circular(borderAngel),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
