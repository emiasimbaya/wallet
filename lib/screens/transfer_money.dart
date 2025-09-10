import 'package:flutter/material.dart';
import '../main.dart';
import '../services/api_service.dart';
import 'choose_value.dart';

class TransferMoneyScreen extends StatelessWidget {
  const TransferMoneyScreen({super.key});
  static const route = '/transfer';

  Widget _tile(BuildContext context, String title, String subtitle, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: kLime, width: 2),
        ),
        child: Row(
          children: [
            Icon(icon, size: 36, color: Colors.black87),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Money'),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          _tile(
            context,
            'PayPal',
            'Transfer Money to your PayPal Account',
            Icons.account_balance_wallet_outlined,
            () async {
              try {
                await apiService.transferMoney(provider: 'paypal', amount: 10);
                // Navigate after successful transfer or to continue the flow.
                Navigator.pushNamed(context, ChooseValueScreen.route);
              } catch (e) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Transfer failed: $e')));
              }
            },
          ),
          const SizedBox(height: 12),
          _tile(context, 'Venmo', 'Transfer Money to your Venmo account', Icons.payments_outlined, () {}),
          const SizedBox(height: 12),
          _tile(context, 'Amazon', 'Get Amazon Gift card using wallet money', Icons.card_giftcard_outlined, () {}),
          const SizedBox(height: 12),
          _tile(context, 'Uber', 'Get Uber Gift card using wallet money', Icons.directions_car_outlined, () {}),
          const Spacer(),
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
