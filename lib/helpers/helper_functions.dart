import 'package:flutter/foundation.dart';

void unimplimentedOnPress() {
  throw UnimplementedError("OnPress Unimplimented!");
}

String? unimplimentedValidator(String? inputValue) {
  debugPrint("User entered: $inputValue");
  return "this validator has not been implemented";
}
