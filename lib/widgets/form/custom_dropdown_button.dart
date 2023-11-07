import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final String value;
  final Widget icon;
  final void Function(String?)? onChanged;
  final List<DropdownMenuItem<String>>? items;
  const CustomDropdownButton(
      {super.key,
      required this.value,
      required this.icon,
      this.onChanged,
      required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.purple),
      child: DropdownButton(
        value: value,
        icon: icon,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
