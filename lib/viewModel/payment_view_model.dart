import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../repo/payment_repo.dart';

class PaymentViewModel with ChangeNotifier{

  final _repo=PaymentRepo();

  Future<void> processPayment(WebViewController controller)async{

    try{
      await _repo.initiatePayment(controller: controller, price: "10");
    }catch(e){
      log(e.toString());
    }
  }

}