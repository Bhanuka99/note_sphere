import 'package:flutter/material.dart';
import 'package:notesphere/utils/colors.dart';

class AppTextStyles{
//title style
static const TextStyle appTitle = TextStyle(
  fontSize: 28,
  color: AppColors.kWhiteColor,
  fontWeight: FontWeight.bold
);
//subtitle style
static const TextStyle appSubtitle = TextStyle(
  fontSize: 24,
  color: AppColors.kWhiteColor,
  fontWeight: FontWeight.w500
);

//description style
static const TextStyle appDescriptionLarge = TextStyle(
  fontSize: 20,
  color: AppColors.kWhiteColor,
  fontWeight: FontWeight.w400
);
static const TextStyle appDescriptionSmall = TextStyle(
  fontSize: 14,
  color: AppColors.kWhiteColor,
  fontWeight: FontWeight.w400
);
//app body style
static const TextStyle appBody = TextStyle(
  fontSize: 16,
  color: AppColors.kWhiteColor,
);
//app button style
static const TextStyle appButton = TextStyle(
  fontSize: 16,
  color: AppColors.kWhiteColor,
  fontWeight: FontWeight.bold,
);
}