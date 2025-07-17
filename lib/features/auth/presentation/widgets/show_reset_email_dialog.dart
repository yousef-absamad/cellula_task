import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cellula_task/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showResetEmailDialog(BuildContext context, String email) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.email_outlined, size: 60, color: Colors.blueAccent),
        const HeightSpace(20),
         Text(
          "Reset Email Sent",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const HeightSpace(12),
        Text(
          "We've sent a password reset link to:\n$email\n\nPlease check your inbox and follow the instructions.",
          style:  TextStyle(fontSize: 16.sp, color: Colors.black87),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    btnOkOnPress: () {},
  ).show();
}
