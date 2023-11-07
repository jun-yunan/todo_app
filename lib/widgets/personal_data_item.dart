import 'package:flutter/material.dart';

class PersonalDataItem extends StatelessWidget {
  final String title;
  final bool? isEmailField;
  final String leadingText;
  final IconData leadingIcon;
  final VoidCallback? onTap;
  const PersonalDataItem({
    super.key,
    required this.title,
    this.onTap,
    required this.leadingText,
    required this.leadingIcon,
    this.isEmailField = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          // color: Color(0xFF444444),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            leadingIcon,
            color: Colors.grey.shade500,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            leadingText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500,
            ),
          )
        ],
      ),
      trailing: isEmailField == false
          ? Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey.shade500,
            )
          : null,
      onTap: onTap,
    );
  }
}
