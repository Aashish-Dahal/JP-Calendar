import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../widgets/day_year_button.dart';

class MonthPicker extends StatelessWidget {
  final String languageCode;
  final ValueNotifier<String> yearNotifier;
  final ValueNotifier<int> monthNotifier;
  final PageController pageController;

  final ValueNotifier<List<int>> dayTimeNotifier;
  const MonthPicker(
      {super.key,
      this.languageCode = "en",
      required this.dayTimeNotifier,
      required this.yearNotifier,
      required this.monthNotifier,
      required this.pageController});

  @override
  Widget build(BuildContext context) {
    final selectedDayChangeNotifier = ValueNotifier<int?>(null);
    final selectedMonthChangeNotifier = ValueNotifier<int>(0);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: 5.0,
            bottom: 20,
            top: 5,
            left: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              languageCode == "en" ? days.length : jpDays.length,
              (i) => Text(
                languageCode == "en" ? days[i].name[0] : jpDays[i].name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
              ),
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
            controller: pageController,
            itemCount: 12,
            onPageChanged: (page) {
              monthNotifier.value = page;
            },
            itemBuilder: (context, month) {
              return ValueListenableBuilder(
                valueListenable: yearNotifier,
                builder: (context, year, child) {
                  int startingWeekDay = getStartingWeekday(
                    int.parse(
                      year.split("-").first,
                    ),
                    month + 1,
                  );

                  return GridView.builder(
                    padding: const EdgeInsets.only(left: 18, right: 13),
                    shrinkWrap: true,
                    itemCount: daysInMonth(month) +
                        ((startingWeekDay == 0 ? 7 : startingWeekDay) - 1),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, day) {
                      if (day <
                          (startingWeekDay == 0 ? 7 : startingWeekDay) - 1) {
                        return const SizedBox();
                      }
                      return ValueListenableBuilder(
                        valueListenable: selectedDayChangeNotifier,
                        builder: (context, selectedDay, _) {
                          return ValueListenableBuilder(
                            valueListenable: selectedMonthChangeNotifier,
                            builder: (context, selectedMonth, _) {
                              return DayYearButton(
                                isSelected: selectedDay == day &&
                                    selectedMonth == month,
                                onPressed: () {
                                  selectedDayChangeNotifier.value = day;
                                  selectedMonthChangeNotifier.value = month;
                                  dayTimeNotifier.value = [
                                    getCalendarDate(startingWeekDay, day),
                                    monthNotifier.value + 1,
                                    getWeekDay(day)
                                  ];
                                },
                                title: getCalendarDate(startingWeekDay, day)
                                    .toString(),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
