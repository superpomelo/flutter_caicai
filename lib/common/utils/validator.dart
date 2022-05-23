bool duCheckStringLength(String input, int length) {
  if (input.isEmpty) {
    return false;
  }
  return input.length >= length;
}
