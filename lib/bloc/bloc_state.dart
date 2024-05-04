import 'package:equatable/equatable.dart';

class BlocState extends Equatable {

  @override
  List<Object?> get props => [];
}

class Error extends BlocState {
  final String message;

  Error({required this.message});

  @override
  List<Object?> get props => [message];
}

class Loading extends BlocState {
}

class Loaded extends BlocState {
  final value;

  Loaded({required this.value});

  @override
  List<Object?> get props => [value];
}
