import 'package:chess_mobile_game/domain/repositories/firebase_repository.dart';
import 'package:chess_mobile_game/feature/home/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel(
      context.read<FirebaseRepository>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => _viewModel,
      child: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              context.go('/home/game');
            },
            child: Text(
              'Join game',
            ),
          ),
        ),
      ),
    );
  }
}
