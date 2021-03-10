import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final itemKey;
  final isCheck;
  final itemText;
  final onChange;
  final author;
  TodoItem(
      {@required this.itemKey,
      this.isCheck = false,
      this.itemText = "",
      this.onChange,
      this.author});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: GestureDetector(
        child: Icon(isCheck ? Icons.check_box : Icons.check_box_outline_blank),
        onTap: () {
          onChange(itemKey, !isCheck);
        },
      ),
      title: Text(itemText),
      subtitle: Text(author),
    );
  }
}
