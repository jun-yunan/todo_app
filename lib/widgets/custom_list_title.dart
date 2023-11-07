import 'package:flutter/material.dart';

class CustomListTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const CustomListTitle({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // tileColor: Colors.grey[100],
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          // color: Color(0xFF444444),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      // iconColor: Colors.red,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          // color: Colors.purple.withOpacity(0.2),
          // color: Colors.purple,
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 24,
          // color: const Color(0xFF444444),
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 20,
        // color: const Color(
        //   0xFF444444,
        // ).withOpacity(0.8),
        color: Theme.of(context).colorScheme.primary,
      ),
      onTap: onTap,
    );
  }
}
