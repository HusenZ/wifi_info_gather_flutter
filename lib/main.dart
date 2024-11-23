import 'package:flutter/material.dart';
import 'wifi_security_scanner.dart';

void main() {
  runApp(const MobileThreatDetectorApp());
}

class MobileThreatDetectorApp extends StatelessWidget {
  const MobileThreatDetectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Threat Detector',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WifiSecurityScanner(),
    );
  }
}
