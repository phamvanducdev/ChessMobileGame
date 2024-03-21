import 'package:chess_mobile_game/di.dart';
import 'package:chess_mobile_game/firebase_options.dart';
import 'package:chess_mobile_game/providers/user_provider.dart';
import 'package:chess_mobile_game/routers/app_router.dart';
import 'package:chess_mobile_game/themes/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserProvider.initialize();
  runApp(
    MultiProvider(
      providers: DependencyInjection.providers,
      child: ChessMobileGameApp(),
    ),
  );
}

class ChessMobileGameApp extends StatefulWidget {
  const ChessMobileGameApp({super.key});

  @override
  State<ChessMobileGameApp> createState() => _ChessMobileGameAppState();
}

class _ChessMobileGameAppState extends State<ChessMobileGameApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: appTheme,
    );
  }
}
