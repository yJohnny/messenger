class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter email';
    }

    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Incorrect email';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter password';
    }

    if (value.length < 6) {
      return 'At least 6 characters';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter name';
    }

    final nameRegex = RegExp(r"^[a-zA-Zа-яА-ЯёЁ]+$");
    if (!nameRegex.hasMatch(value.trim())) {
      return 'The name can only contain letters';
    }

    return null;
  }
}
