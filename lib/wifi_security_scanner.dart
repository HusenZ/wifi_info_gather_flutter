import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

class WifiSecurityScanner extends StatefulWidget {
  const WifiSecurityScanner({super.key});

  @override
  State<WifiSecurityScanner> createState() => _WifiSecurityScannerState();
}

class _WifiSecurityScannerState extends State<WifiSecurityScanner> {
  String wifiName = 'Unknown';
  String wifiBSSID = 'Unknown';
  String wifiIP = 'Unknown';
  String securityStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    fetchWifiInfo();
  }

  Future<void> fetchWifiInfo() async {
    final info = NetworkInfo();
    try {
      final name = await info.getWifiName(); // Get Wi-Fi name (SSID)
      final bssid = await info.getWifiBSSID(); // Get Wi-Fi BSSID
      final ip = await info.getWifiIP(); // Get device IP address

      setState(() {
        wifiName = name ?? 'Unknown';
        wifiBSSID = bssid ?? 'Unknown';
        wifiIP = ip ?? 'Unknown';
        securityStatus = analyzeSecurity(name);
      });
    } catch (e) {
      setState(() {
        securityStatus = 'Error fetching Wi-Fi details';
      });
    }
  }

  String analyzeSecurity(String? wifiName) {
    if (wifiName == null || wifiName.isEmpty) {
      return 'No Wi-Fi connected';
    }
    // Example logic for determining security:
    if (wifiName.startsWith('Guest') || wifiName.contains('Open')) {
      return 'Insecure Network (Open Wi-Fi)';
    }
    return 'Secure Network';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wi-Fi Security Scanner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Wi-Fi Name: $wifiName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('BSSID: $wifiBSSID', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('IP Address: $wifiIP', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Security Status: $securityStatus',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: securityStatus == 'Secure Network'
                        ? Colors.green
                        : Colors.red)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchWifiInfo,
              child: Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
