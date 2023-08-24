import 'package:doctor_green/helpers/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog(BuildContext context, String text) {
  return showGenericDialog(
    context: context,
    title: "Something went wrong",
    content: text,
    optionBuilder: () {
      return {
        "OK": null,
      };
    },
  );
}
