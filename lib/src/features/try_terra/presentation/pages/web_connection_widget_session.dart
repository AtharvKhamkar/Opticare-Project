import 'dart:async';

import 'package:flutter/material.dart';

class WebConnectionWidgetSession extends StatefulWidget {
  const WebConnectionWidgetSession({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  State<WebConnectionWidgetSession> createState() =>
      _WebConnectionWidgetSessionState();
}

class _WebConnectionWidgetSessionState
    extends State<WebConnectionWidgetSession> {
  late int expireTime;
  late String sessionId;
  late String status;
  late String webUrl;

  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    expireTime = widget.data['expires_in'] ?? 0;
    sessionId = widget.data['session_id'] ?? '';
    status = widget.data['status'] ?? '';
    webUrl = widget.data['url'] ?? '';
    _timer = Timer.periodic(Duration(seconds: expireTime), (timer) {
      setState(() {
        _currentTime = DateTime.now(); // Update the current time
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when disposing the widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vizzhy web Connection'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Text(
            _currentTime.toLocal().toString().split(' ')[1].split('.')[0],
            // Format time to HH:mm:ss
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Connect to IOT'))
        ],
      )),
    );
  }

  // Future<void> _launchUrl(String url) async {
  //   if (!await launchUrl(Uri.parse(url))) {
  //     throw Exception('Could not launch $url');
  //   }
  // }
}
