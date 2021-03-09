import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

const primaryColor = Color(0xFF6CAF97);
const buttonColor = Color(0xFF73A794);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _current = 0;
  void _onChangePage(page) {
    setState(() {
      _current = page;
    });
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
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: _current == 0
            ? Column(
                children: [
                  HeaderText(
                      titleText: "TO DO", subtitleText: "Input your list here.")
                ],
              )
            : Column(
                children: [
                  HeaderText(titleText: "DONE", subtitleText: "Good job ! :3")
                ],
              ),
      ),
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
              onPressed: () {},
              child: Icon(Icons.add),
            )
          : null,
    );
  }
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
          print(_emailController.text);
          print(_passwordController.text);
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
