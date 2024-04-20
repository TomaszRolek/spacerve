class Validators {
  static final email = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
}

extension Validator on String {
  get isEmailValid {
    return Validators.email.hasMatch(this);
  }

  get isPasswordValid {
    return length >= 8;
  }
}
