import 'package:flutter/material.dart'
    show
        BuildContext,
        MainAxisAlignment,
        Navigator,
        Row,
        StatelessWidget,
        Text,
        TextButton,
        VoidCallback,
        Widget;

class CancelOkButton extends StatelessWidget {
  final String languageCode;
  final VoidCallback onSubmit;
  const CancelOkButton(
      {super.key, required this.onSubmit, this.languageCode = "en"});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(languageCode == "en" ? "cancel" : "キャンセル"),
        ),
        TextButton(
          onPressed: onSubmit,
          child: Text(languageCode == "en" ? "OK" : "設定"),
        ),
      ],
    );
  }
}
