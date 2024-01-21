import 'package:chess_mobile_game/domain/repositories/firebase_repository.dart';
import 'package:chess_mobile_game/feature/splash/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SplashViewModel(
      context.read<FirebaseRepository>(),
    );
    _viewModel.initialize(
      runApp: () => context.go('/home'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<(double, double, String)> icons = [
      (-0.15, -0.1, 'assets/icons/bg_splash_knight.png'),
      (0.6, 0.05, 'assets/icons/bg_splash_king.png'),
      (0.0, 0.1, 'assets/icons/bg_splash_pawn.png'),
      (0.0, 0.4, 'assets/icons/bg_splash_knight.png'),
      (0.5, 0.3, 'assets/icons/bg_splash_bishop.png'),
      (0.8, 0.5, 'assets/icons/bg_splash_king.png'),
      (0.4, 0.6, 'assets/icons/bg_splash_queen.png'),
      (-0.15, 0.7, 'assets/icons/bg_splash_king.png'),
      (0.7, 0.8, 'assets/icons/bg_splash_knight.png'),
    ];

    return Provider(
      create: (context) => _viewModel,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF121529),
                Color(0xFF121529),
              ], // Adjust the colors as needed
            ),
          ),
          child: Stack(
            children: [
              ...icons.map(
                (icon) => Positioned(
                  left: icon.$1 * MediaQuery.of(context).size.width,
                  top: icon.$2 * MediaQuery.of(context).size.height,
                  child: Image.asset(
                    icon.$3,
                    height: 240,
                    opacity: AlwaysStoppedAnimation(0.1),
                  ),
                ),
              ),
              Image.asset(
                'assets/icons/bg_splash.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
              ),
              Center(
                child: SizedBox(
                  height: 240,
                  child: Image.asset(
                    'assets/icons/ic_splash.png',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
