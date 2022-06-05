import 'package:flutter/widgets.dart';

String? getErrorMessage(String field, List<dynamic> errors) {
  for (var v in errors) {
    if (v.contains(field)) {
      return v;
    }
  }
  return null;
}

// unfocus any textfield in context
unfocus(BuildContext context) {
  var currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}
