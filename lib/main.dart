import 'package:flutter/material.dart';
import 'package:my_app/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:my_app/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser>.value(
        value: AuthService().user, child: MaterialApp(home: Wrapper()));
  }
}
