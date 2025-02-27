import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../viewModel/payment_view_model.dart';


class PaymentIntegrationView extends StatefulWidget {
  final String accountType; // Pass the price to the screen
  const PaymentIntegrationView({super.key, required this.accountType});
  @override
  _PaymentIntegrationViewState createState() => _PaymentIntegrationViewState();
}

class _PaymentIntegrationViewState extends State<PaymentIntegrationView> {
  late WebViewController controller;


  @override
  void initState() {
    super.initState();
    final paymentPr=Provider.of<PaymentViewModel>(context,listen: false);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => log('Page Started: $url'),
          onPageFinished: (url) => log('Page Finished: $url'),
          onWebResourceError: (error) => log('Web Resource Error: $error'),
          onNavigationRequest: (request)async {
            if (request.url.contains("RC=00")) {
              if (kDebugMode) {
                print("Success");
              }
            //Your code here after successful transaction i.e updating value in db
              if(mounted){
                Navigator.pop(context);
              }
              return NavigationDecision.prevent; // Prevent further navigation if needed
            }
            else  if (request.url.contains("RC=01")) {
              if (kDebugMode) {
                print("Failed");
              }
              Navigator.pop(context);
              return NavigationDecision.prevent; // Prevent further navigation if needed
            }
            if (kDebugMode) {
              print('Navigation Request: ${request.url}');
            }
            return NavigationDecision.navigate; // Allow navigation
          },
        ),
      );
    Future.delayed(const Duration(seconds: 2),(){

      paymentPr.processPayment(controller);

    });
  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}