import 'package:flutter/material.dart';
import 'package:quran_journey/features/auth/presentation/auth_routes.dart';
import 'package:quran_journey/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:quran_journey/features/auth/presentation/pages/login_page.dart';
import 'package:quran_journey/features/auth/presentation/pages/signup_page.dart';

/// Email / Google auth flow with named routes.
class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: AuthRoutes.login,
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case AuthRoutes.login:
            page = const LoginPage();
            break;
          case AuthRoutes.signUp:
            page = const SignupPage();
            break;
          case AuthRoutes.forgotPassword:
            page = const ForgotPasswordPage();
            break;
          default:
            page = const LoginPage();
        }
        return PageRouteBuilder<void>(
          settings: settings,
          pageBuilder: (_, animation, secondaryAnimation) => page,
          transitionsBuilder: (_, animation, secondaryAnimation, child) {
            final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0.04, 0), end: Offset.zero).animate(curved),
                child: child,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 320),
        );
      },
    );
  }
}
