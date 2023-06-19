import 'package:flutter/material.dart';

class ListViewBuilderSpacer extends StatelessWidget {
  const ListViewBuilderSpacer(
      {Key? key,
      required this.itemBuilder,
      required this.spacerWidget,
      required this.itemCount,
      this.physics,
      this.padding,
      this.scrollDirection})
      : super(key: key);

  final Widget? Function(BuildContext, int)? itemBuilder;
  final Widget spacerWidget;
  final int? itemCount;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Axis? scrollDirection;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount!,
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      scrollDirection: scrollDirection ?? Axis.vertical,
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      itemBuilder: itemBuilder!,
      padding: padding,
      separatorBuilder: (BuildContext context, int index) {
        return spacerWidget;
      },
    );
  }
}
