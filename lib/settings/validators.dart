extension PasswordValidator on String {
  bool validatePassword() {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(this);
  }

  bool isValidMatricNumber() {
    return RegExp(r'^\d{2}\/\d{4}$').hasMatch(this);
  }

  // bool isValidEmail() {
  //   return RegExp(
  //           r'^([a-zA-Z0-9]+)([\-\_\.]*)([a-zA-Z0-9]*)([@])([a-zA-Z0-9]{2,})([\.][a-zA-Z]{2,3})$')
  //       .hasMatch(this);
  // }

  bool isValidEmail() {
    // Regular expression for validating email
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    return emailRegex.hasMatch(this);
  }

  bool isValidPhoneNumber() {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  bool isValidPassword() {
    return this.length >= 8;
  }
}
