import 'package:flutter/material.dart';
import 'package:homecare/Const/appText.dart';
import 'package:homecare/Const/size.dart';

class HandleEmpty extends StatelessWidget {
  final String message;
  final IconData icon;

  HandleEmpty({required this.message, this.icon = Icons.not_interested});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: displayHeight(context) * 0.2, color: Colors.grey),
          SizedBox(height: 10),
          AppText(
            text: message,
            size: displayHeight(context) * 0.024,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
