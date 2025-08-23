class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (value.length > 10) {
      return 'Password must not exceed 10 characters';
    }

    return null;
  }

  static String? validateLength(String? value, int minLength, int maxLength) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    if (value.trim().length < minLength) {
      return 'Field must be at least 2 characters';
    }

    if (value.trim().length > maxLength) {
      return 'Field must not exceed 10 characters';
    }

    return null;
  }

  static String? validateConfirmPassword(
    String? value,
    String? originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != originalPassword) {
      return 'Passwords do not match';
    }

    return null;
  }
}
