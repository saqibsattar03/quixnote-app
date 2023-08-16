import 'package:flutter/material.dart';

class AppCircularButton extends StatelessWidget {
  const AppCircularButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.svg,
    required this.width,
    required this.height,
  });

  final Function() onPressed;
  final Color color;
  final Widget svg;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: color,
        shape: const CircleBorder(),
        minimumSize: Size(height, width),
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: svg,
    );
  }
}
