import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

const primaryColor = Color(0xFF6CAF97);
const buttonColor = Color(0xFF73A794);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ApplicationState(),
        builder: (context, _) => Consumer<ApplicationState>(
            builder: (ctx, auth, _) => MaterialApp(
                home: auth.credentials != null ? HomePage() : LoginPage())));
  }
}

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
    print(key);
    print(status);
    // var tempList = items;
    // var targetElement = tempList.firstWhere((element) => element.key == key);
    // targetElement.finish = status;
    // tempList.removeWhere((element) => element.key == key);
    // tempList.add(targetElement);
    // setState(() {
    //   items = tempList;
    // });
  }

  void _onAddTodo(text) {
    print(text);
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

class Todo {
  String key;
  String text;
  bool finish;
  Todo({this.key, this.text, this.finish});
}

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Text(
              "LOGIN",
              style: TextStyle(fontSize: 20),
            )),
        leadingWidth: 120,
        toolbarHeight: 40,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeaderText(
                titleText: "Welcome!",
                subtitleText: "to login page",
                ratio: 1.5,
              ),
              InputText(controller: _emailController, labelText: "Email"),
              InputText(
                controller: _passwordController,
                labelText: "Password",
                isPassword: true,
              )
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        child: Icon(Icons.chevron_right),
        onPressed: () {
          final email = _emailController.text;
          final password = _passwordController.text;
          Provider.of<ApplicationState>(context, listen: false)
              .login(email, password, context);
        },
      ),
    );
  }
}

class InputText extends StatelessWidget {
  final controller;
  final labelText;
  final isPassword;
  InputText(
      {@required this.controller,
      @required this.labelText,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 12),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Color(0xFFD5D8DE))),
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  final titleText;
  final subtitleText;
  final ratio;
  HeaderText({this.titleText, this.subtitleText, this.ratio = 1.0});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(children: [
            Text(titleText,
                style: TextStyle(color: primaryColor, fontSize: 32 * ratio))
          ]),
          Row(children: [
            Text(subtitleText, style: TextStyle(fontSize: 16 * ratio))
          ])
        ],
      ),
    );
  }
}

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
                onChange: onChange))
          ],
        ));
  }
}

class TodoItem extends StatelessWidget {
  final itemKey;
  final isCheck;
  final itemText;
  final onChange;
  TodoItem(
      {@required this.itemKey,
      this.isCheck = false,
      this.itemText = "",
      this.onChange});
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: GestureDetector(
          child:
              Icon(isCheck ? Icons.check_box : Icons.check_box_outline_blank),
          onTap: () {
            onChange(itemKey, !isCheck);
          },
        ),
        title: Text(itemText));
  }
}

class ApplicationState extends ChangeNotifier {
  String credentials;
  List<Todo> todoItems = [];
  ApplicationState() {
    init();
  }
  Future<void> init() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        credentials = user.email;
      } else {
        credentials = null;
      }
      notifyListeners();
    });
    fetchItem();
  }

  Future<void> fetchItem() async {
    FirebaseFirestore.instance
        .collection('todos')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      List<Todo> tempTodo = [];
      snapshot.docs.forEach((element) {
        tempTodo.add(Todo(
            finish: element.data()['finish'],
            key: element.id,
            text: element.data()['text']));
      });
      todoItems = tempTodo;
      notifyListeners();
    });
  }

  Future<void> addItem(String text) async {
    FirebaseFirestore.instance.collection('todos').add({
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'finish': false,
      'text': text,
      'author': credentials
    });
  }

  Future<void> changeItemStatus() async {}

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    UserInfo userInfo = UserInfo(email: email, password: password);
    try {
      var status = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(userInfo.email);
      if (!status.contains('password')) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: userInfo.email, password: userInfo.email);
      } else {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: userInfo.email, password: userInfo.password);
        } on FirebaseAuthException catch (_) {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text("Email is already used with others password"),
                  ));
        }
      }
    } on FirebaseAuthException catch (_) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Email is Invalid Format"),
              ));
    }
    notifyListeners();
  }
}

class UserInfo {
  String email;
  String password;
  UserInfo({this.email, this.password});
}
