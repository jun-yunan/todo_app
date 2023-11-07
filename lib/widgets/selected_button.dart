import 'package:flutter/material.dart';

class ButtonList extends StatefulWidget {
  @override
  _ButtonListState createState() => _ButtonListState();
}

class _ButtonListState extends State<ButtonList> {
  List<bool> isButtonSelected = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          title: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                isButtonSelected[index] ? Colors.cyan : Colors.blue,
              ),
            ),
            onPressed: () {
              setState(() {
                isButtonSelected[index] = !isButtonSelected[index];
              });
            },
            child: Text('Nút $index'),
          ),
        );
      },
    );
  }
}
