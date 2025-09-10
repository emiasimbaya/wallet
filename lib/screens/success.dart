// lib/screens/success.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../main.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});
  static const route = '/success';

  @override
  Widget build(BuildContext context) {
    final amount = (ModalRoute.of(context)?.settings.arguments as double?) ?? 37.74;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 👇🏼 REMPLAZO DEL CustomPaint POR SVG
            Center(
              child: SvgPicture.asset(
                'assets/Vector.svg', // tu mapache
                width: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),

            Text(
              '\$${amount.toStringAsFixed(2)} has been transferred to your PayPal account.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black87),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: kLime,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: kTealDark,
        indicatorColor: Colors.white10,
        selectedIndex: 1,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined, color: Colors.white), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.wallet_rounded, color: Colors.white), label: 'Wallet'),
          NavigationDestination(icon: Icon(Icons.emoji_events_outlined, color: Colors.white), label: 'Badges'),
          NavigationDestination(icon: Icon(Icons.person_outline, color: Colors.white), label: 'Profile'),
        ],
      ),
    );
  }
}
