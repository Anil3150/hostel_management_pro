import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/payments.controller.dart';

class PaymentsScreen extends GetView<PaymentsController> {
  const PaymentsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaymentsScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PaymentsScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
