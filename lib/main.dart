import 'package:flutter/material.dart';
import 'package:meet_buddy_app/chatdashboard.dart';
import 'package:meet_buddy_app/chatmessage.dart';
//import 'package:meet_buddy_app/chatpage.dart';
import 'package:meet_buddy_app/userprovider.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';
import 'loginpage.dart';
import 'signup.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // Add other providers here if needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => DashboardPage(),
        '/chat': (context) => ChatMessage(),
      },
    );
  }
}
