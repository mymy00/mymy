import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/barell.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthChecker(),
      routes: {
        '/LoginPage': (context) => LoginPage(),
        '/SignupPage': (context) => SignupPage(),
        '/MyHomePage': (context) => SpokefyHomePage(),
      },
      title: 'My Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking auth state
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          // User is logged in, navigate to home page
          return SpokefyHomePage();
        } else {
          // User is not logged in, navigate to login page
          return LoginPage();
        }
      },
    );
  }

  Future<User?> _getUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
