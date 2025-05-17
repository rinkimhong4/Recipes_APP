class PhoneNumberFormatter {
  static String format(String phone, {bool maskMiddleDigits = true}) {
    if (phone.isEmpty) return phone;

    if (phone.startsWith('+')) {
      final countryCodeEnd = phone.indexOf(' ') + 1;
      if (countryCodeEnd > 0) {
        final countryPart = phone.substring(0, countryCodeEnd);
        final numberPart = phone.substring(countryCodeEnd);
        return maskMiddleDigits
            ? '$countryPart${_maskMiddleDigits(numberPart)}'
            : phone;
      }
    }
    return maskMiddleDigits ? _maskMiddleDigits(phone) : phone;
  }

  static String _maskMiddleDigits(String number) {
    final digitsOnly = number.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length <= 6) return number;

    final part1 = digitsOnly.substring(0, 3);
    final part2 = '***';
    final part3 = digitsOnly.substring(6);

    final hasSpace = number.contains(' ');
    final hasDash = !hasSpace && number.contains('-');

    return hasSpace
        ? '$part1 $part2 $part3'
        : hasDash
        ? '$part1-$part2-$part3'
        : '$part1$part2$part3';
  }
}
