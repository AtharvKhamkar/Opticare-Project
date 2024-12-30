import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/try_terra_controller.dart';

class TryTerraAppLogs extends StatefulWidget {
  const TryTerraAppLogs({super.key});

  @override
  State<TryTerraAppLogs> createState() => _TryTerraAppLogsState();
}

class _TryTerraAppLogsState extends State<TryTerraAppLogs> {
  final _controller = Get.find<TryTerraController>();

  @override
  void initState() {
    super.initState();
    // _controller.getNutrition(Connection.healthConnect, DateTime.now().subtract(Duration(days: 15)), DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TryTerra App Logs'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(_controller.logsList.length, (ind) {
            final data = _TryTerraLogs.fromJson(_controller.logsList[ind]);
            return SizedBox(
              width: double.infinity,
              child: ListTile(
                // tileColor: Colors.red,
                title: Text(data.name),
                subtitle: Column(
                  children: [
                    Text('connection name : ${data.connectionName}'),
                    Text('Is Success : ${data.success}'),
                    SelectableText('Data : ${data.data}'),
                    Text('Error : ${data.error}'),
                  ],
                ),
                trailing: SizedBox(
                  width: 55,
                  child: Text(data.timeStampInUTC
                      .toLocal()
                      .toIso8601String()
                      .replaceAll('T', ' ')
                      .substring(0, 16)),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _TryTerraLogs {
  final String name;
  final String connectionName;
  final bool success;
  final String error;
  final String data;
  final DateTime timeStampInUTC;

  _TryTerraLogs({
    required this.name,
    required this.connectionName,
    required this.success,
    required this.error,
    required this.data,
    required this.timeStampInUTC,
  });

  // From JSON: Factory constructor to create an instance from JSON
  factory _TryTerraLogs.fromJson(Map<String, dynamic> json) {
    return _TryTerraLogs(
      name: json['name'] as String? ?? 'NA',
      connectionName: json['ConnectionName'] as String? ?? 'NA',
      success: json['success'] as bool? ?? false,
      error: json['error'] as String? ?? 'No Error',
      data: json['data'] as String? ?? 'No Data',
      timeStampInUTC:
          DateTime.parse((json['timeStamp_in_UTC'] as String? ?? '1947-08-15')),
    );
  }

  // To JSON: Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ConnectionName': connectionName,
      'success': success,
      'error': error,
      'data': data,
      'timeStamp_in_UTC': timeStampInUTC.toUtc().toIso8601String(),
    };
  }
}
