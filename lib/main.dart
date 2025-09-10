import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'screens/choose_value.dart';
import 'screens/custom_amount.dart';
import 'screens/redeem_reward.dart';
import 'screens/success.dart';
import 'screens/transfer_money.dart';

void main() => runApp(const WalletApp());

const kLime = Color(0xFFB6E63E);
const kTealDark = Color(0xFF1F4C4F);
const kBg = Color(0xFFF6F9FC);
const kCardAlt = Color(0xFFF0F6FA);

class WalletApp extends StatelessWidget {
  const WalletApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Wallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: kBg,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w700),
          titleMedium: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      home: const WalletScreen(),
      routes: {
        ChooseValueScreen.route: (_) => const ChooseValueScreen(),
        CustomAmountScreen.route: (_) => const CustomAmountScreen(),
        RedeemRewardScreen.route: (_) => const RedeemRewardScreen(),
        SuccessScreen.route: (_) => const SuccessScreen(),
        TransferMoneyScreen.route: (_) => const TransferMoneyScreen(),
      },
    );
  }
}

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  static const double total = 42.0;
  static const double current = 37.74;

  @override
  Widget build(BuildContext context) {
    final progress = (current / total).clamp(0.0, 1.0);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const _BalanceChip(amount: current),
                  const Spacer(),
                  _RoundIconButton(icon: Icons.notifications_none_rounded, onTap: () {}),
                ],
              ),
              const SizedBox(height: 16),

              Text('Total Wallet Value', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),

              _TotalCard(
                amount: current,
                subtitle: 'You earned in this month',
                onClaim: () => Navigator.pushNamed(context, TransferMoneyScreen.route),
              ),

              const SizedBox(height: 24),
              Text('Earning this month', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),

              _EarningsProgress(
                progress: progress,
                labelRight: '\$${current.toStringAsFixed(2)} / \$${total.toStringAsFixed(0)}',
              ),

              const SizedBox(height: 28),

              // Mapache (SVG desde assets)
              Center(
                child: SvgPicture.asset(
                  'assets/Vector.svg',
                  width: 300,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: kTealDark,
        indicatorColor: const Color.fromARGB(159, 255, 255, 255),
        selectedIndex: 1,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.white),
            selectedIcon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.wallet_rounded, color: Colors.white),
            selectedIcon: Icon(Icons.wallet, color: Colors.white),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined, color: Colors.white),
            selectedIcon: Icon(Icons.emoji_events, color: Colors.white),
            label: 'Badges',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: Colors.white),
            selectedIcon: Icon(Icons.person, color: Colors.white),
            label: 'Profile',
          ),
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
      decoration: BoxDecoration(color: kLime.withOpacity(.2), borderRadius: BorderRadius.circular(12)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.attach_money_rounded, size: 18),
        const SizedBox(width: 6),
        Text(amount.toStringAsFixed(2), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
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
        child: const Padding(padding: EdgeInsets.all(10), child: Icon(Icons.notifications_none_rounded)),
      ),
    );
  }
}

class _TotalCard extends StatelessWidget {
  const _TotalCard({required this.amount, required this.subtitle, required this.onClaim});
  final double amount;
  final String subtitle;
  final VoidCallback onClaim;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('\$${amount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(height: 6),
              Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ]),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kLime.withOpacity(.85),
              foregroundColor: Colors.black87,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            ),
            onPressed: onClaim,
            child: const Text('Claim', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ]),
      ),
    );
  }
}

class _EarningsProgress extends StatelessWidget {
  const _EarningsProgress({required this.progress, required this.labelRight});
  final double progress; // 0..1
  final String labelRight;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: kCardAlt,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(children: [
          SizedBox(
            height: 28,
            child: Stack(alignment: Alignment.centerLeft, children: [
              Container(
                height: 12,
                decoration: BoxDecoration(color: const Color(0xFFE7F0F5), borderRadius: BorderRadius.circular(12)),
              ),
              LayoutBuilder(builder: (context, c) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: c.maxWidth * progress,
                  height: 12,
                  decoration: BoxDecoration(color: const Color(0xFFBBDD6B), borderRadius: BorderRadius.circular(12)),
                );
              }),
              Align(
                alignment: Alignment(progress * 2 - 1, 0),
                child: SvgPicture.asset(
                  'assets/Group.svg',
                  width: 28,
                  fit: BoxFit.contain,
                ),
              ),
            ]),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(labelRight, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF5F6B6E))),
          ),
        ]),
      ),
    );
  }
}
