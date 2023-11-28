import 'package:flutter/material.dart';

class TaskOptions extends StatelessWidget {
  const TaskOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      children: [
        SimpleDialogOption(
          padding: EdgeInsets.symmetric(vertical: 5),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const ListTile(
            leading: Icon(
              Icons.edit,
              size: 24,
            ),
            title: Text(
              "Edit Task",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SimpleDialogOption(
          padding: EdgeInsets.symmetric(vertical: 5),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const ListTile(
            leading: Icon(
              Icons.timer,
              size: 24,
            ),
            title: Text(
              "Set Reminder",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SimpleDialogOption(
          padding: EdgeInsets.symmetric(vertical: 5),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: ListTile(
            leading: Icon(
              Icons.delete,
              color: Colors.red.shade800,
              size: 24,
            ),
            title: Text(
              "Delete Task",
              style: TextStyle(
                fontSize: 16,
                color: Colors.red.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
