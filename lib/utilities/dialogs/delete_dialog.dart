import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'logout',
    content: 'Are you sure you want to Delete this objekt?',
    optionsBuilder: () => {
      'Cancel': false,
      'delete': true,
    },
  ).then(
    (value) => value ?? false,
  );
}