import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:theft_detecting_system/config/environment.dart';
import 'package:theft_detecting_system/core/di/injection.dart';
import 'package:theft_detecting_system/features/auth/presentation/pages/account_page.dart';
import 'package:theft_detecting_system/features/auth/presentation/pages/authentication_page.dart';
import 'package:theft_detecting_system/features/auth/presentation/providers/auth_provider.dart';
import 'package:theft_detecting_system/features/home/presentation/pages/home_page.dart';
import 'package:theft_detecting_system/features/home/presentation/providers/video_provider.dart';
import 'package:theft_detecting_system/features/notification/presentation/pages/notification_page.dart';
import 'package:theft_detecting_system/features/notification/presentation/providers/notification_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Load environment variables
  await Environment.load();
  
  // Initialize dependency injection
  await init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<AuthProvider>()),
        ChangeNotifierProvider(create: (_) => sl<VideoProvider>()),
        ChangeNotifierProvider(create: (_) => sl<NotificationProvider>()),
      ],
      child: MaterialApp(
        title: 'Theft Detecting System',
        initialRoute: AuthenticationPage.routeName,
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
          AuthenticationPage.routeName: (context) => const AuthenticationPage(),
          HomePage.routeName: (context) => const HomePage(),
          NotificationPage.routeName: (context) => const NotificationPage(),
          AccountPage.routeName: (context) => const AccountPage(),
        },
      ),
    );
  }
}
