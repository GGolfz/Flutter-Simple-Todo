import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/Todo.dart';
import '../model/UserInfo.dart';

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
            text: element.data()['text'],
            author: element.data()['author']));
      });
      todoItems = tempTodo;
      notifyListeners();
    });
  }

  Future<void> addItem(String text) async {
    try {
      FirebaseFirestore.instance.collection('todos').add({
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'finish': false,
        'text': text,
        'author': credentials
      });
    } on FirebaseException catch (_) {}
  }

  Future<void> changeItemStatus(key, status) async {
    try {
      FirebaseFirestore.instance
          .collection('todos')
          .doc(key)
          .update({'finish': status});
    } on FirebaseException catch (_) {}
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    UserInformation userInfo =
        UserInformation(email: email, password: password);
    try {
      var status = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(userInfo.email);
      if (!status.contains('password')) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: userInfo.email, password: userInfo.password);
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
