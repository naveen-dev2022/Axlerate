import 'dart:ui';

class ECardCategoryModel {
  ECardCategoryModel(
      {required this.title,
      required this.imageUrl,
      this.borderColor,
      this.bgColor});

  String title;
  String imageUrl;
  Color? bgColor;
  Color? borderColor;
}
