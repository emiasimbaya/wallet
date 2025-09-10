import 'package:flutter/material.dart';
import '../main.dart';
import 'custom_amount.dart';

class ChooseValueArgs {
  final String method;
  ChooseValueArgs({required this.method});
}

class ChooseValueScreen extends StatelessWidget {
  const ChooseValueScreen({super.key});
  static const route = '/choose-value';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ChooseValueArgs?;
    final method = args?.method ?? 'PayPal';

    Widget pill(String text, VoidCallback onTap) {
      return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: kLime, width: 2),
          ),
          child: Center(
              child: Text(text,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
        ),
      );
    }

    void go(double amount) {
      Navigator.pushNamed(context, CustomAmountScreen.route,
          arguments: CustomAmountArgs(presetAmount: amount, method: method));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Transfer to $method'),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.7,
              children: [
                pill(r'\$10', () => go(10)),
                pill(r'\$20', () => go(20)),
                pill(r'\$37.74', () => go(37.74)),
                pill('Custom', () => go(0)),
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _bottomBar() => NavigationBar(
        backgroundColor: kTealDark,
        indicatorColor: Colors.white10,
        selectedIndex: 1,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined, color: Colors.white), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.wallet_rounded, color: Colors.white), label: 'Wallet'),
          NavigationDestination(icon: Icon(Icons.emoji_events_outlined, color: Colors.white), label: 'Badges'),
          NavigationDestination(icon: Icon(Icons.person_outline, color: Colors.white), label: 'Profile'),
        ],
      );
}
