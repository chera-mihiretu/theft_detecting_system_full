import 'package:flutter/material.dart';
import 'package:theft_detecting_system/features/auth/presentation/pages/account_page.dart';
import 'package:theft_detecting_system/features/auth/presentation/pages/authentication_page.dart';
import 'package:theft_detecting_system/features/home/presentation/pages/home_page.dart';
import 'package:theft_detecting_system/features/notification/presentation/pages/notification_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: NotificationPage.routeName,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
      ),
      builder: (context, child) {
        return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        );
      },

      routes: {
        NotificationPage.routeName: (context) => const NotificationPage(),
        HomePage.routeName: (context) => const HomePage(),
        AuthenticationPage.routeName: (context) => const AuthenticationPage(),
        AccountPage.routeName: (context) => const AccountPage(),
      },
    );
  }
}
