import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final Icon? prefixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? hintText;
  final bool readOnly;
  final String? initialValue;
  final void Function(String)? onChanged;
  const CustomTextFormField({
    super.key,
    required this.label,
    this.controller,
    this.onTap,
    this.prefixIcon,
    this.keyboardType,
    this.maxLines,
    this.hintText,
    this.readOnly = false,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade500,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          initialValue: initialValue,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            // color: Color(0xFF444444),
            color: Theme.of(context).colorScheme.primary,
          ),
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.purple,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 2,
                color: Colors.purple,
              ),
            ),
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }
}
