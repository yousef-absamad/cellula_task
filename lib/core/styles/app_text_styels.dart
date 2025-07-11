import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle welcomeText = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static final TextStyle forgotPassword = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.white,
  );

  static final TextStyle buttonText = GoogleFonts.poppins(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}
