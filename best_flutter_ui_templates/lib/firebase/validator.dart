class Validator {
  static String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }

    if (name.isEmpty) {
      return 'İsim Boş Olamaz';
    }

    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }

    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'E-Posta değeri boş olamaz.';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Lütfen doğru bir E-Posta girin';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }

    if (password.isEmpty) {
      return 'Şifre değeri boş olamaz';
    } else if (password.length < 6) {
      return 'Lütfen 6 karakterden fazla bir değer girin.';
    }

    return null;
  }

  static String? validateSirketAdi({required String? sirketAdi}) {
    if (sirketAdi == null) {
      return null;
    }

    if (sirketAdi.isEmpty) {
      return 'Şirket Adı Boş Olamaz.';
    }

    return null;
  }

  static String? validateSirketAdres({required String? sirketAdres}) {
    if (sirketAdres == null) {
      return null;
    }

    if (sirketAdres.isEmpty) {
      return 'Şirketin Adresi Boş Olamaz.';
    }

    return null;
  }

  static String? validateSirketNum({required String? sirketNum}) {
    if (sirketNum == null) {
      return null;
    }

    if (sirketNum.isEmpty) {
      return 'Şirketin Telefonu Boş Olamaz.';
    }

    return null;
  }
}
