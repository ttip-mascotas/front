import "dart:convert";

import "package:flutter/material.dart";
import "package:mascotas/model/treatment.dart";
import "package:stomp_dart_client/stomp_dart_client.dart";

class WebSocketDatasource {
  StompClient? _client;
  final baseUrl = "ws://10.0.2.2:8080/notifications";

  Future<void> connectWebSocket(
    Function(Treatment treatment) onTreatmentReceived,
    int treatmentId,
  ) async {
    _client = StompClient(
      config: StompConfig(
        url: baseUrl,
        onDebugMessage: debugPrint,
        onConnect: (_) => onConnectCallback(
          treatmentId,
          onTreatmentReceived,
        ),
      ),
    );
    _client?.activate();
  }

  void onConnectCallback(
    int treatmentId,
    Function(Treatment treatment) onTreatmentReceived,
  ) {
    _client?.subscribe(
        destination: "/topic/treatments/$treatmentId",
        callback: (frame) {
          final body = frame.body;
          if (body != null) {
            final treatment = Treatment.fromJson(jsonDecode(body));
            onTreatmentReceived(treatment);
          }
        });
  }

  Future<void> closeWebSocket() async {
    if (_client != null) {
      _client?.deactivate();
      _client = null;
    }
  }

  void checkTreatmentLog(
      int treatmentId, int treatmentLogId, bool administrated) {
    final body = {"administered": administrated};
    _client?.send(
      destination: "/app/treatments/$treatmentId/logs/$treatmentLogId",
      body: jsonEncode(body),
    );
  }
}
