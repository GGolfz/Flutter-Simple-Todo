import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

const primaryColor = Color(0xFF6CAF97);
const buttonColor = Color(0xFF73A794);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: LoginPage()),
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
              WelcomeText(),
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

class WelcomeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(children: [
            Text("Welcome!",
                style: TextStyle(color: primaryColor, fontSize: 48))
          ]),
          Row(children: [Text("to login page", style: TextStyle(fontSize: 24))])
        ],
      ),
    );
  }
}
