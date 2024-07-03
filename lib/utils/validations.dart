class Validators {
  validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return false;
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  validateName(String? name) {
    if (name == null || name.isEmpty) {
      return false;
    }
    return true;
  }

  validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return false;
    }
    return true;
  }

  validatePasswordConfirmation(String? password, String? passwordConfirmation) {
    if (password == null || password.isEmpty) {
      return false;
    }

    if (passwordConfirmation == null || passwordConfirmation.isEmpty) {
      return false;
    }

    if (password != passwordConfirmation) {
      return false;
    }
    return true;
  }

  validatePhone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return false;
    }

    const pattern = r'^[0-9]{10}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(phone)) {
      return false;
    }
    return true;
  }
}
