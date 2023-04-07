import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class CalendarHeader extends StatelessWidget {
  final Color? headerBackgroundColor;

  final ValueListenable<List<int>> dateTimeListenable;
  const CalendarHeader(
      {super.key,
      required this.dateTimeListenable,
      this.headerBackgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 15,
        left: 15,
      ),
      color: headerBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "select date".toUpperCase(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                ),
          ),
          const SizedBox(
            height: 40,
          ),
          ValueListenableBuilder(
            valueListenable: dateTimeListenable,
            builder: (context, dateTime, _) {
              return Text(
                getSelectedYearMonthDay(dateTime),
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 20),
              );
            },
          )
        ],
      ),
    );
  }
}
