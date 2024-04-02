String? emptyFieldValidator(String? text) {
  if (text == null || text.trim().isEmpty) {
    return "Este campo no puede estar vacío";
  }
  return null;
}