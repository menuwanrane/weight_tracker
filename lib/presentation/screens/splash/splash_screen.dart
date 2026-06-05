import 'dart:async';

import 'package:flutter/material.dart';

import '../../widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _openApp();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _openApp() {
    _timer = Timer(const Duration(seconds: 1), () {
      if (!mounted) {
        return;
      }

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const BottomNav()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Icon(Icons.monitor_weight, size: 96)),
    );
  }
}
