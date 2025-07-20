import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Titles
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    fontFamily: 'Inter',
    color: AppColors.titleText,
    height: 1.2,
  );
  
  static const TextStyle subtitle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: 'Inter-Regular',
    color: AppColors.subtitleText,
  );
  
  // Component headings
  static const TextStyle componentHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
    color: AppColors.titleText,
    height: 1.3,
  );
  
  // Body Text
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    fontFamily: 'Inter-Regular',
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodyRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter-Regular',
    color: AppColors.textPrimary,
  );
  
  static const TextStyle bodySecondary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter-Regular',
    color: AppColors.textSecondary,
  );
  
  // Small Text
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: 'Inter-Regular',
    color: AppColors.textSecondary,
  );
  
  static const TextStyle small = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter',
    color: AppColors.primary,
  );
  
  // Button Text
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Inter',
    color: Colors.white,
  );
} 