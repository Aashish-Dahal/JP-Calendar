import 'package:flutter/material.dart';

class DayYearButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final String title;
  const DayYearButton({
    super.key,
    this.textStyle,
    this.isSelected = false,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: textStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                ),
        foregroundColor: isSelected ? Colors.white : Colors.black,
        padding: EdgeInsets.zero,
        backgroundColor:
            isSelected ? Theme.of(context).colorScheme.secondary : null,
      ),
      onPressed: onPressed,
      child: Text(
        title,
      ),
    );
  }
}
