import 'package:bank_alfalah_flutter_integration/view/payment_integraion_view.dart';
import 'package:bank_alfalah_flutter_integration/viewModel/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => PaymentViewModel(),
        child: PaymentIntegrationView(),
      ),
    );
  }
}

