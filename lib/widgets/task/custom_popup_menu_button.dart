import 'package:flutter/material.dart';

class CustomPopupMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDelete;
  const CustomPopupMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.isDelete,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem(
      child: ListTile(
        // tileColor: Colors.purple,
        leading: Icon(
          icon,
          color: isDelete
              ? Colors.red.shade600
              : Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: isDelete
                ? Colors.red.shade600
                : Theme.of(context).colorScheme.primary,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
