import 'package:flutter/material.dart';

class CustomFilledButtonIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final Widget label;
  final EdgeInsetsGeometry? margin;

  const CustomFilledButtonIcon({
    required this.onPressed,
    required this.icon,
    required this.label,
    this.margin = EdgeInsets.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,
      margin: margin,
      child: FilledButton.icon(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: icon,
        label: label,
      ),
    );
  }
}
