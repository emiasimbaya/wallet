import 'package:flutter/material.dart';
import '../main.dart';
import 'success.dart';

class RedeemRewardArgs {
  final double amount;
  final String method;
  RedeemRewardArgs({required this.amount, required this.method});
}

class RedeemRewardScreen extends StatefulWidget {
  const RedeemRewardScreen({super.key});
  static const route = '/redeem';

  @override
  State<RedeemRewardScreen> createState() => _RedeemRewardScreenState();
}

class _RedeemRewardScreenState extends State<RedeemRewardScreen> {
  final _emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as RedeemRewardArgs?;
    final amount = args?.amount ?? 37.74;
    final method = args?.method ?? 'PayPal';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Redeem Reward'),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          const SizedBox(height: 8),
          const Text('Reward', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 4),
          Text('\$${amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: kTealDark)),
          const SizedBox(height: 8),
          Text('Redeeming: \$${amount.toStringAsFixed(2)}\nRemaining: \$0',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 16),
          Text('Enter the email or phone number linked to your $method account',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 12),
          TextField(
            controller: _emailCtrl,
            decoration: InputDecoration(
              hintText: 'email@domain.com',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: kLime, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14)),
              onPressed: () => Navigator.pushReplacementNamed(context, SuccessScreen.route, arguments: amount),
              child: const Text('Next', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ]),
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
