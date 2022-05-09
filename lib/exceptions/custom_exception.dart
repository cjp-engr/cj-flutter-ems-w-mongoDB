class CustomException implements Exception {
  String message;
  CustomException([this.message = 'Something went wrong']) {
    message = 'News Exception: $message';
  }

  @override
  String toString() {
    return message;
  }
}
