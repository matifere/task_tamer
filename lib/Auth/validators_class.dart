class ValidatorsClass {
  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El correo no puede estar vacío';
    }

    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) {
      return 'Ingresá un formato de correo válido';
    }

    return null;
  }

  String? passValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'La contraseña es obligatoria';
    }

    if (value.length < 6) {
      return 'Debe tener al menos 6 caracteres';
    }

    return null;
  }
}
