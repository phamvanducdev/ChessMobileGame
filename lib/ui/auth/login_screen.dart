import 'package:chess_mobile_game/repositories/auth_repository.dart';
import 'package:chess_mobile_game/services/auth/models/google_auth_model.dart';
import 'package:chess_mobile_game/ui/auth/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ProxyProvider<AuthRepository, LoginBLoC>(
          update: (context, authRepository, previous) => previous ?? LoginBLoC(authRepository: authRepository),
          dispose: (_, bLoC) => bLoC.dispose(),
        ),
      ],
      child: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBLoC _bLoC;

  @override
  void initState() {
    super.initState();
    _bLoC = context.read<LoginBLoC>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Google'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _requestLoginGoogle(),
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }

  _requestLoginGoogle() async {
    // context.read<AppProvider>().showLoading();
    try {
      await _bLoC.requestLogin(GoogleAuthModel());
      // context.read<AppProvider>().hideLoading();
    } catch (error) {
      // context.read<AppProvider>().hideLoading();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}
