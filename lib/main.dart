import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/appState.dart';
import './screen/HomeScreen.dart';
import './screen/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

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
