
import 'package:flutter/widgets.dart';

class Transaction {
  final DateTime date;
  final String description;
  final double amount; // negative for outflow
  Transaction({required this.date, required this.description, required this.amount});
}

class WalletModel extends ChangeNotifier {
  double _balance = 120.50;
  final List<Transaction> _history = [];

  double get balance => _balance;
  List<Transaction> get history => List.unmodifiable(_history);

  void addFunds(double amount, {String note = 'Top up'}) {
    _balance += amount;
    _history.insert(0, Transaction(date: DateTime.now(), description: note, amount: amount));
    notifyListeners();
  }

  bool redeem(double amount, {required String method}) {
    if (amount <= 0) return false;
    if (amount > _balance) return false;
    _balance -= amount;
    _history.insert(
      0,
      Transaction(
        date: DateTime.now(),
        description: 'Redeem via $method',
        amount: -amount,
      ),
    );
    notifyListeners();
    return true;
  }
}

class WalletScope extends InheritedNotifier<WalletModel> {
  const WalletScope({
    Key? key,
    required WalletModel notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static WalletModel of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<WalletScope>();
    assert(scope != null, 'WalletScope not found in the widget tree');
    return scope!.notifier!;
  }
}
