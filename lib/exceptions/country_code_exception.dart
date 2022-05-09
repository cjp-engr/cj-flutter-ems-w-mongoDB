class CountryCodeException implements Exception {
  String message;
  CountryCodeException([this.message = 'Something went wrong']) {
    message = 'News Exception: $message';
  }

  @override
  String toString() {
    return message;
  }
}
