import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_browsing_app/screens/home_screen.dart';
import 'package:movie_browsing_app/screens/login_screen.dart';
import 'package:movie_browsing_app/screens/signup_screen.dart';
import 'screens/movie_detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  await dotenv.load(fileName: ".env");
  runApp(const MovieBrowsingApp());
}


class MovieBrowsingApp extends StatelessWidget {
  const MovieBrowsingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Browsing App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
      ),
      home: AuthGate(),
      routes: {
        '/movie-detail': (context) => MovieDetailScreen(),
      },
    );
  }
}


class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context,snap){
          if (snap.connectionState==ConnectionState.waiting){
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }
          if (snap.hasData){
            return const HomeScreen();
          }
          return const LoginScreen();
        }
    );
  }

}
