import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/broadcast.controller.dart';

class BroadcastScreen extends GetView<BroadcastController> {
  const BroadcastScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BroadcastScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BroadcastScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
