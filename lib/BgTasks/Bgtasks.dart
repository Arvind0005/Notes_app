import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:isolate/isolate.dart';
import 'package:path_provider/path_provider.dart'; // Optional for persistence

class BackgroundSyncService {
  static BackgroundSyncService? _instance;
  SendPort? _isolateSendPort;

  BackgroundSyncService._internal();

  factory BackgroundSyncService() {
    if (_instance == null) {
      _instance = BackgroundSyncService._internal();
    }
    return _instance!;
  }

  Future<void> startSync() async {
    final isolate = await Isolate.spawn(_isolateEntry, _isolateSendPort);
    _isolateSendPort = await isolate.receivePort.send(null);
  }

  static void _isolateEntry(SendPort responsePort) async {
    Isolate.exit();
  }
}
