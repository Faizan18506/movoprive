import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_links/app_links.dart';

import 'package:movoprive/features/authentication/otp/cubit/otp_cubit.dart';
import 'package:movoprive/features/authentication/services/auth_service.dart';
import 'package:movoprive/features/authentication/services/verify_email_service.dart';
import 'package:movoprive/features/onBoardingscreens/letsgetstarted_Screen.dart';
import 'package:movoprive/utils/app_logger.dart';

import 'features/authentication/login/cubit/login_cubit.dart';
import 'features/authentication/login/login_email.dart';
import 'features/navigation/screens/main_screen.dart';
import 'features/splash_screen.dart';
import 'features/authentication/cubit/register_cubit.dart';
import 'features/authentication/services/register_service.dart';

import 'features/authentication/register/Register_Screen.dart';

// Define a global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String tag = '_MyAppState'; // Define the tag variable here
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  final VerifyEmailService _verifyEmailService = VerifyEmailService();

  @override

  void initState() {
    super.initState();
    _initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle links when app is already running
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri uri) {
      AppLogger.i(tag, 'Deep link received (app running): $uri');
      _handleDeepLink(uri);
    }, onError: (err) {
      AppLogger.e(tag, 'Error handling deep links stream', err);
    });

    // Handle links when app is opened from a link
    try {
      final initialUri = await _appLinks.getInitialAppLink();
      if (initialUri != null) {
        AppLogger.i(tag, 'Initial deep link received (app opened): $initialUri');
        _handleDeepLink(initialUri);
      }
    } catch (e) {
      AppLogger.e(tag, 'Error getting initial link', e);
    }
  }

  Future<void> _handleDeepLink(Uri uri) async {
    AppLogger.i(tag, 'Handling deep link: $uri');

    // Extract the token from the query parameters
    final token = uri.queryParameters['token'];

    if (token != null) {
      AppLogger.d(tag, 'Verification token extracted: $token');

      try {
        AppLogger.i(tag, 'Attempting to verify email via API with token');
        // Call verify email API
        final success = await _verifyEmailService.verifyEmail(token);

        if (success) {
          AppLogger.i(tag, 'Email verification API successful');
          // Show success message and navigate to login
          if (mounted) {
            ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
              const SnackBar(
                content: Text('Email verified successfully! You can now login.'),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate to login screen with verification success parameter
            navigatorKey.currentState!.pushNamedAndRemoveUntil(
              '/login',
              (route) => false,
              arguments: {'verificationSuccess': true},
            );
          }
        }
      } catch (e) {
        AppLogger.e(tag, 'Error during email verification API call', e);
        if (mounted) {
          ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
            SnackBar(
              content: Text('Failed to verify email: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      AppLogger.w(tag, 'No token found in the verification link');
      if (mounted) {
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          const SnackBar(
            content: Text('Invalid verification link. No token found.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize AuthService
    final authService = AuthService();
    final registerService = RegisterService();

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(authService),
        ),
        BlocProvider<OtpCubit>(
          create: (context) => OtpCubit(authService),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(registerService),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey, // Set the global navigator key
        title: 'MoVa Prive',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => const LoginEmailScreen(),
          '/register': (context) => const RegisterScreen(),
        },
      ),
    );
  }
}