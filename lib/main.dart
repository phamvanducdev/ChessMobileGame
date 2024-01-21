import 'package:chess_mobile_game/domain/repositories/firebase_repository.dart';
import 'package:chess_mobile_game/firebase_options.dart';
import 'package:chess_mobile_game/routers/app_router.dart';
import 'package:chess_mobile_game/themes/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChessMobileGameApp());
}

class ChessMobileGameApp extends StatefulWidget {
  const ChessMobileGameApp({super.key});

  @override
  State<ChessMobileGameApp> createState() => _ChessMobileGameAppState();
}

class _ChessMobileGameAppState extends State<ChessMobileGameApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuth>(
          create: (context) => FirebaseAuth.instance,
        ),
        Provider<FirebaseFirestore>(
          create: (context) => FirebaseFirestore.instance,
        ),
        ProxyProvider2<FirebaseAuth, FirebaseFirestore, FirebaseRepository>(
          update: (context, firebaseAuth, firebaseFirestore, previous) =>
              previous ??
              FirebaseRepositoryImpl(
                firebaseAuth,
                firebaseFirestore,
              ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'ChessMobileGame',
        theme: appTheme,
        routerConfig: appRouter,
      ),
    );
  }
}
