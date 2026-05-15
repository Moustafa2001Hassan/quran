abstract final class AuthValidators {
  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Enter your email';
    if (!RegExp(r'^[\w\.\-+]+@([\w\-]+\.)+[a-zA-Z]{2,}$').hasMatch(v)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? password(String? value, {int minLength = 8}) {
    final v = value ?? '';
    if (v.isEmpty) return 'Enter your password';
    if (v.length < minLength) {
      return 'Use at least $minLength characters';
    }
    return null;
  }

  static String? confirmPassword(String? password, String? confirm) {
    if (confirm == null || confirm.isEmpty) return 'Confirm your password';
    if (password != confirm) return 'Passwords do not match';
    return null;
  }
}
