import 'package:equatable/equatable.dart';
import 'package:mascotas/model/treatment.dart';

abstract class WebSocketState extends Equatable {}

class WebSocketInitial extends WebSocketState {
  @override
  List<Object?> get props => [];
}

class WebSocketClosed extends WebSocketState {
  @override
  List<Object?> get props => [];
}

class WebSocketError extends WebSocketState {
  final String errorMessage;

  WebSocketError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class WebSocketTreatmentReceived extends WebSocketState {
  final Treatment treatment;

  WebSocketTreatmentReceived(this.treatment);

  @override
  List<Object?> get props => [treatment];
}
