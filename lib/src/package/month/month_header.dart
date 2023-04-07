import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class MonthHeader extends StatelessWidget {
  final String languageCode;

  final VoidCallback onPressed;
  final PageController monthSwitchController;
  final ValueNotifier<int> monthListener;
  final ValueNotifier<String> yearListener;

  const MonthHeader(
      {super.key,
      this.languageCode = "en",
      required this.monthListener,
      required this.yearListener,
      required this.onPressed,
      required this.monthSwitchController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder(
            valueListenable: yearListener,
            builder: (context, year, _) {
              return ValueListenableBuilder(
                valueListenable: monthListener,
                builder: (context, month, _) {
                  return InkWell(
                    onTap: onPressed,
                    child: Text(
                      getSelectedYearMonth(year, month, languageCode),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                          ),
                    ),
                  );
                },
              );
            },
          ),
          Row(
            children: List.generate(
              2,
              (i) => IconButton(
                iconSize: 18,
                onPressed: () {
                  i == 0
                      ? (monthSwitchController.previousPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.bounceIn,
                        ))
                      : (monthSwitchController.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.bounceIn,
                        ));
                },
                icon: i == 0
                    ? const Icon(Icons.arrow_back_ios)
                    : const Icon(Icons.arrow_forward_ios),
              ),
            ),
          )
        ],
      ),
    );
  }
}
