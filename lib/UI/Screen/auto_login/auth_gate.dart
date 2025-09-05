import 'package:flutter/material.dart';
import 'package:movie_app/blocs/auth_cubit/login/login_view_model.dart';
import 'package:movie_app/utils/app_routes.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }
  

  void _checkLogin() async {
   var token= await LoginViewModel.getSavedToken();

    if (mounted) {
      if (token != null && token.isNotEmpty) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
