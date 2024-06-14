import 'package:mascotas/model/treatment.dart';

abstract class WebSocketState {}

class WebSocketInitial extends WebSocketState {}

class WebSocketClosed extends WebSocketState {}

class WebSocketError extends WebSocketState {
  final String errorMessage;

  WebSocketError(this.errorMessage);
}

class WebSocketTreatmentReceived extends WebSocketState {
  final Treatment treatment;

  WebSocketTreatmentReceived(this.treatment);
}