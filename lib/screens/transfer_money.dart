import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';
import 'choose_value.dart';

class TransferMoneyScreen extends StatelessWidget {
  const TransferMoneyScreen({super.key});
  static const route = '/transfer';

  @override
  Widget build(BuildContext context) {
    Widget card(String logoUrl, String title, String subtitle, VoidCallback onTap) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kLime, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.network(logoUrl, height: 40, fit: BoxFit.contain),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 4),
              Text(subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ),
      );
    }

    Widget section(String title, List<Widget> children) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.chevron_left, size: 20, color: kLime),
            const SizedBox(width: 4),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: children[0]),
            const SizedBox(width: 16),
            Expanded(child: children[1]),
          ]),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                _BalanceChip(amount: WalletScreen.current),
                const Spacer(),
                _RoundIconButton(
                    icon: Icons.notifications_none_rounded, onTap: () {}),
              ]),
              const SizedBox(height: 16),
              Text('Transfer Money',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      section('Transfer Money', [
                        card(
                            'https://upload.wikimedia.org/wikipedia/commons/b/b5/PayPal.svg',
                            'PayPal',
                            'Transfer Money to your PayPal Account',
                            () => Navigator.pushNamed(
                                context, ChooseValueScreen.route)),
                        card(
                            'https://upload.wikimedia.org/wikipedia/commons/4/4e/Venmo_logo.svg',
                            'Venmo',
                            'Transfer Money to your Venmo Account',
                            () {}),
                      ]),
                      const SizedBox(height: 24),
                      section('Convert to gift card', [
                        card(
                            'https://upload.wikimedia.org/wikipedia/commons/a/a9/Amazon_logo.svg',
                            'Amazon',
                            'Get Amazon Gift card using wallet money',
                            () {}),
                        card(
                            'https://upload.wikimedia.org/wikipedia/commons/c/cc/Uber_logo_2018.svg',
                            'Uber',
                            'Get Uber Gift card using wallet money',
                            () {}),
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: kTealDark,
        indicatorColor: Colors.white10,
        selectedIndex: 1,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Colors.white),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.wallet_rounded, color: Colors.white),
              label: 'Wallet'),
          NavigationDestination(
              icon: Icon(Icons.emoji_events_outlined, color: Colors.white),
              label: 'Badges'),
          NavigationDestination(
              icon: Icon(Icons.person_outline, color: Colors.white),
              label: 'Profile'),
        ],
      ),
    );
  }
}

class _BalanceChip extends StatelessWidget {
  const _BalanceChip({required this.amount});
  final double amount;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: kLime.withOpacity(.2),
          borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.attach_money_rounded, size: 18),
        const SizedBox(width: 6),
        Text(amount.toStringAsFixed(2),
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kLime.withOpacity(.2),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.all(10), child: Icon(icon)),
      ),
    );
  }
}
