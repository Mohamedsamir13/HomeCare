import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.underline = false, this.textAlign, // Add this parameter to control the underline
  });

  final String text;
   final TextAlign? textAlign;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final bool
      underline; // This parameter determines if the text should be underlined

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style:
      Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: size,

            fontWeight: fontWeight,
            color: color,
            decoration: underline
                ? TextDecoration.underline
                : TextDecoration.none, // Conditional underline
          ),
    );
  }
}
