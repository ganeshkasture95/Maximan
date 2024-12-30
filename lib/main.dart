// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maximan/firebase_options.dart';
import 'package:maximan/views/login_view.dart';
import 'package:maximan/views/register_view.dart';
import 'package:maximan/views/verify_email.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      useMaterial3: true,
    ),
    routes: {
      '/login': (context) => const LoginView(),
      '/register': (context) => const RegisterView(),
      '/verify': (context) => const VerifyEmailView(),
    },
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;

            // if (user?.emailVerified ?? false) {
            //   print("You are verified");
            //   return const Text("done");
            // } else {
            //   return const VerifyEmailView();
            // }
            return const LoginView();

          default:
            return const CircularProgressIndicator(
              color: Colors.blueAccent,
            );
        }
      },
    );
  }
}
