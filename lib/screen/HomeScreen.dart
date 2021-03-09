import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/appState.dart';
import '../config/color.dart';
import '../widget/headerText.dart';
import '../widget/inputText.dart';
import '../widget/listItem.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _current = 0;
  var _itemController = TextEditingController();
  void _onChangePage(page) {
    setState(() {
      _current = page;
    });
  }

  void _onItemStatusChange(key, status) {
    Provider.of<ApplicationState>(context, listen: false)
        .changeItemStatus(key, status);
  }

  void _onAddTodo(text) {
    Provider.of<ApplicationState>(context, listen: false).addItem(text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              _current == 0 ? "TODO" : "DONE",
              style: TextStyle(fontSize: 20),
            )),
        leadingWidth: 120,
        toolbarHeight: 40,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Provider.of<ApplicationState>(context, listen: false).logout();
              })
        ],
      ),
      body: Consumer<ApplicationState>(
          builder: (ctx, appState, _) => Container(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: _current == 0
                    ? Column(
                        children: [
                          HeaderText(
                              titleText: "TO DO",
                              subtitleText: "Input your list here."),
                          SizedBox(
                            height: 24,
                          ),
                          ListItem(
                            items: appState.todoItems
                                .where((element) => element.finish == false)
                                .toList(),
                            onChange: _onItemStatusChange,
                          )
                        ],
                      )
                    : Column(
                        children: [
                          HeaderText(
                              titleText: "DONE", subtitleText: "Good job ! :3"),
                          SizedBox(
                            height: 24,
                          ),
                          ListItem(
                              items: appState.todoItems
                                  .where((element) => element.finish == true)
                                  .toList(),
                              onChange: _onItemStatusChange)
                        ],
                      ),
              )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _current,
        selectedItemColor: buttonColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add_comment), label: "Todo"),
          BottomNavigationBarItem(icon: Icon(Icons.done), label: "Done")
        ],
        onTap: _onChangePage,
      ),
      floatingActionButton: _current == 0
          ? FloatingActionButton(
              backgroundColor: buttonColor,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => Dialog(
                          child: Container(
                            width: 320,
                            height: 240,
                            padding: EdgeInsets.only(
                                top: 30, left: 30, right: 30, bottom: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                HeaderText(
                                  titleText: "TO DO",
                                  subtitleText: "Input your list here.",
                                ),
                                InputText(
                                    controller: _itemController,
                                    labelText: "To do list"),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            _onAddTodo(_itemController.text);
                                            _itemController.text = '';
                                          },
                                          child: Text(
                                            "DONE",
                                            style:
                                                TextStyle(color: primaryColor),
                                          ))
                                    ]),
                              ],
                            ),
                          ),
                        ));
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
