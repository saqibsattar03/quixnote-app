import 'package:flutter/material.dart';


class AppCircularButton extends StatelessWidget {
  const AppCircularButton(
      {super.key,
      required this.onPressed,
      required this.color,
      required this.svg,
      this.height,
      this.width});

  final Function() onPressed;
  final Color color;
  final Widget svg;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          const CircleBorder(),
        ),
      ),
      child: Ink(
        decoration: ShapeDecoration(
          color: color,
          shape: const CircleBorder(),
        ),
        child: SizedBox(
          width: width ?? 50, // Adjust this value as needed
          height: height ?? 50, // Adjust this value as needed
          child: Center(
            child: svg,
          ),
        ),
      ),
    );
  }
}
