import 'package:flutter/material.dart';
import './todoItem.dart';

class ListItem extends StatelessWidget {
  final List items;
  final Function onChange;
  ListItem({this.items, this.onChange});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: ListView(
          children: [
            ...items.map((e) => TodoItem(
                  itemKey: e.key,
                  itemText: e.text,
                  isCheck: e.finish,
                  onChange: onChange,
                  author: e.author,
                ))
          ],
        ));
  }
}
