class Validate {
  static String cleanText(String text) {
    final allowedChars = RegExp(
      r'[a-zA-Z0-9\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\s.,!?؛،ـ\-\n\r\u0660-\u0669\u06F0-\u06F9#_]',
    );
    return text.split('').where((char) => allowedChars.hasMatch(char)).join();
  }
}
