import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog <void>(
    context: context,
    title: 'an error occurred',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
