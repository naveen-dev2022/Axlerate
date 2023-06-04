import 'package:axlerate/Themes/color_constants.dart';
import 'package:axlerate/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AxleFilterChip extends ConsumerWidget {
  const AxleFilterChip({required this.text, required this.onTap, super.key});

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(color: iconGrey, borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.only(left: defaultMobilePadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(text),
                IconButton(
                    iconSize: 15,
                    onPressed: () {
                      onTap();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          ),
        ),
        // const SizedBox(width: defaultPadding)
      ],
    );
  }
}

class FilterChipList extends StatelessWidget {
  const FilterChipList({required this.items, super.key});
  final List<AxleFilterChip> items;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: defaultPadding,
      runSpacing: defaultPadding,
      children: [for (AxleFilterChip item in items) AxleFilterChip(text: item.text, onTap: item.onTap)],
    );
  }
}
