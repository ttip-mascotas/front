String? emptyFieldValidator(String? text) {
  if (text == null || text.trim().isEmpty) {
    return "Este campo no puede estar vacío";
  }
  return null;
}

String? numberGreaterThanZero(String? text) {
  if (text != null && int.parse(text) <= 0) {
    return "El numero ingresado debe ser mayor a cero";
  }
  return emptyFieldValidator(text);
}