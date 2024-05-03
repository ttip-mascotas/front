class BlocState {}

class Error extends BlocState {
  final String message;

  Error({required this.message});
}

class Loading extends BlocState {}

class Loaded extends BlocState {
  final value;

  Loaded({required this.value});
}
