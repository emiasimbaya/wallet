import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_wallet_flow/main.dart';

void main() {
  testWidgets('WalletApp smoke test', (WidgetTester tester) async {
    // Carga la aplicación
    await tester.pumpWidget(const WalletApp());

    // Verifica que aparece el texto del valor total de la billetera
    expect(find.text('Total Wallet Value'), findsOneWidget);

    // Verifica que el botón Claim está presente
    expect(find.text('Claim'), findsOneWidget);

    // Verifica que la barra inferior de navegación existe
    expect(find.byIcon(Icons.wallet_rounded), findsOneWidget);
  });
}
