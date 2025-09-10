import 'package:flutter/material.dart';
import '../main.dart';
import 'redeem_reward.dart';

class CustomAmountArgs {
  final double presetAmount;
  CustomAmountArgs({this.presetAmount = 0});
}

class CustomAmountScreen extends StatefulWidget {
  const CustomAmountScreen({super.key});
  static const route = '/custom-amount';

  @override
  State<CustomAmountScreen> createState() => _CustomAmountScreenState();
}

class _CustomAmountScreenState extends State<CustomAmountScreen> {
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  final _to = 'John Doe';
  final _from = 'Main Wallet';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as CustomAmountArgs?;
    if (args != null && args.presetAmount > 0) {
      _amountCtrl.text = args.presetAmount.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Sending to', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          const SizedBox(height: 4),
          Text(_to, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Text('From account', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          const SizedBox(height: 4),
          Text(_from, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),

          // Amount field
          Container(
            decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kLime, width: 2),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(children: [
              const Text('\$', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _amountCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    hintText: '0.00', border: InputBorder.none,
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 8),
          const Text('Enter the amount you want to send', style: TextStyle(fontSize: 12, color: Colors.grey)),

          const SizedBox(height: 12),
          TextField(
            controller: _noteCtrl,
            decoration: InputDecoration(
              hintText: 'Add a note (optional)',
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
              style: FilledButton.styleFrom(
                backgroundColor: kLime, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                final amt = double.tryParse(_amountCtrl.text) ?? 0;
                Navigator.pushNamed(context, RedeemRewardScreen.route, arguments: amt);
              },
              child: const Text('Continue', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ]),
      ),
    );
  }
}
