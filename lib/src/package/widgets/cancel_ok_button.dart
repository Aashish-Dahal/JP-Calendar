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
  final VoidCallback onSubmit;
  const CancelOkButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: onSubmit,
          child: const Text("OK"),
        ),
      ],
    );
  }
}
