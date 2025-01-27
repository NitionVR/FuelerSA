import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fuel_price_tracker/pages/home_page.dart';
import 'package:fuel_price_tracker/pages/login_page.dart';
import 'package:fuel_price_tracker/repositories/firebase_repository.dart';
import 'package:fuel_price_tracker/services/auth_service.dart';
import 'package:fuel_price_tracker/viewmodels/fuel_price_viewmodel.dart';
import 'package:provider/provider.dart';
import 'config/firebase_config.dart';
import 'models/fuel_price_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: FirebaseConfig.apiKey,
      authDomain: FirebaseConfig.authDomain,
      projectId: FirebaseConfig.projectId,
      storageBucket: FirebaseConfig.storageBucket,
      messagingSenderId: FirebaseConfig.messagingSenderId,
      appId: FirebaseConfig.appId,
      measurementId: FirebaseConfig.measurementId,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),

        ChangeNotifierProvider(create: (_) => FuelPriceModel()),
        ChangeNotifierProxyProvider<FuelPriceModel, FuelPriceViewModel>(
          create: (_) => FuelPriceViewModel(FirebaseRepository(), FuelPriceModel()),
          update: (_, fuelPriceModel, fuelPriceViewModel) =>
              FuelPriceViewModel(FirebaseRepository(), fuelPriceModel),
        ),
      ],
      child: MaterialApp(
        title: 'FuelerSA',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const AuthWrapper(),
        routes: {
          '/home': (context) => const MyHomePage(title: 'FuelerSA'),
          '/login': (context) => const LoginPage(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    // Show loading indicator while checking auth state
    if (authService.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Return appropriate page based on auth state
    return authService.user != null
        ? const MyHomePage(title: 'FuelerSA')
        : const LoginPage();
  }
}