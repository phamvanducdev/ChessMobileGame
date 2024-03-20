import 'package:chess_mobile_game/providers/user_provider.dart';
import 'package:chess_mobile_game/repositories/auth_repository.dart';
import 'package:chess_mobile_game/repositories/game_repository.dart';
import 'package:chess_mobile_game/ui/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ProxyProvider2<AuthRepository, GameRepository, HomeBLoC>(
          update: (context, authRepository, gameRepository, previous) =>
              previous ??
              HomeBLoC(
                authRepository: authRepository,
                gameRepository: gameRepository,
              ),
          dispose: (_, bLoC) => bLoC.dispose(),
        ),
      ],
      child: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBLoC _bLoC;

  @override
  void initState() {
    super.initState();
    _bLoC = context.read<HomeBLoC>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 100.0),
            ElevatedButton(
              onPressed: () => context.go('/game/x3p81x'),
              child: Text('JoinGame'),
            ),
            UserProvider.userLogged != null
                ? ElevatedButton(
                    onPressed: () => _bLoC.createNewGame(),
                    child: Text('NewGame'),
                  )
                : Container(),
            UserProvider.userLogged == null
                ? ElevatedButton(
                    onPressed: () => context.go('/auth'),
                    child: Text('Login'),
                  )
                : ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _bLoC.onLogout();
                      });
                    },
                    child: Text('Logout'),
                  ),
          ],
        ),
      ),
    );
  }
}
