// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

//  If you want 6 children on 3 Rows, then change the childAspectRatio to MediaQuery.of(context).size.aspectRatio * 3 / 2

//  If you want 6 children on 2 Rows, then increase crossAxisCount to 3, and change the childAspectRatio to MediaQuery.of(context).size.aspectRatio * 2 / 3

///Note: You can continue like that. if you want m Rows of n children, the childAspectRatio should be m/n

class GridViewBuilder extends StatelessWidget {
  GridViewBuilder(
      {Key? key,
      required this.itemBuilder,
      required this.itemCount,
      required this.constrain,
      this.childAspectRatio,
      this.physics,
      this.padding,
      this.crossAxisSpacing,
      this.mainAxisSpacing})
      : super(key: key);

  final Widget? Function(BuildContext, int)? itemBuilder;
  final BoxConstraints? constrain;
  final int? itemCount;
  final double? childAspectRatio;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  double? crossAxisSpacing;
  double? mainAxisSpacing;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount ?? 0,
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      itemBuilder: itemBuilder!,
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: childAspectRatio ?? 1.0,
        crossAxisCount: 2,
        crossAxisSpacing: crossAxisSpacing ?? 25,
        mainAxisSpacing: mainAxisSpacing ?? 25,
      ),
    );
  }
}

// GridViewBuilder(
// itemCount: 20,
// padding: const EdgeInsets.symmetric(horizontal: 15),
// physics: const NeverScrollableScrollPhysics(),
// itemBuilder: (BuildContext context, int index) {
// return Container(
// color: Colors.red,
// );
// },
// constrain: constrain,
// childAspectRatio: 3 / 9,
// )
