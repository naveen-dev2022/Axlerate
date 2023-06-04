import 'package:flutter/material.dart';

class DiscountTypeDropdown extends StatefulWidget {
  const DiscountTypeDropdown({Key? key, required this.value, required this.onChanged}) : super(key: key);

  final IconData value;
  final void Function(IconData?) onChanged;

  @override
  State<DiscountTypeDropdown> createState() => _DiscountTypeDropdownState();
}

class _DiscountTypeDropdownState extends State<DiscountTypeDropdown> {
  List<IconData> discountTypeList = [Icons.percent, Icons.currency_rupee];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<IconData>(
      value: widget.value,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      itemHeight: 64,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: widget.onChanged,
      items: discountTypeList.map<DropdownMenuItem<IconData>>((IconData value) {
        return DropdownMenuItem<IconData>(
          value: value,
          child: Icon(
            value,
            size: 17.5,
          ),
        );
      }).toList(),
    );
  }
}
