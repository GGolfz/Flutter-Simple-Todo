import 'package:flutter/material.dart';
import '../config/color.dart';
import '../widget/inputText.dart';
import '../widget/headerText.dart';
import 'package:provider/provider.dart';
import '../provider/appState.dart';

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
