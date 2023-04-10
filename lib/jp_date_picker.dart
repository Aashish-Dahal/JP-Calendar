library jp_calendar;

import 'package:flutter/material.dart';
import 'package:jp_calendar/src/package/month/month_header.dart';
import 'package:jp_calendar/src/package/month/month_picker.dart';
import 'package:jp_calendar/src/package/widgets/calendar_header.dart';
import 'package:jp_calendar/src/package/widgets/cancel_ok_button.dart';
import 'package:jp_calendar/src/package/year/year_header.dart';
import 'package:jp_calendar/src/package/year/year_picker.dart' as ENJP;
import 'package:jp_calendar/src/utils/constants.dart';

class JPDateTimePicker extends StatefulWidget {
  final String initialValue;
  final String languageCode;
  final DateTimeCallback dateTimeCallback;

  const JPDateTimePicker(
      {super.key,
      required this.dateTimeCallback,
      this.languageCode = "en",
      this.initialValue = ''});

  @override
  State<JPDateTimePicker> createState() => _JPDateTimePickerState();
}

class _JPDateTimePickerState extends State<JPDateTimePicker> {
  final headerNotifier = ValueNotifier<int>(0);
  final dayTimeListener = ValueNotifier<List<int>>([]);
  final monthListener = ValueNotifier<int>(0);
  late final PageController _monthPageController;
  late final ValueNotifier<String> dropDownJPERaListener;
  final selectedYearListener =
      ValueNotifier<String>(DateTime.now().year.toString());
  late final PageController _pageController;
  int index = 0;
  @override
  void initState() {
    YearFactory.getYears();
    _monthPageController = PageController(initialPage: 0);
    _pageController = PageController(initialPage: 0);
    dropDownJPERaListener =
        ValueNotifier<String>(getDropDownInitialValue(widget.initialValue));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(30),
      child: Container(
        height: 522,
        width: double.infinity,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            CalendarHeader(
              languageCode: widget.languageCode,
              headerBackgroundColor: Theme.of(context).colorScheme.secondary,
              dateTimeListenable: dayTimeListener,
            ),
            Container(
              margin: EdgeInsets.zero,
              height: 405,
              color: Colors.white,
              child: Column(
                children: [
                  ValueListenableBuilder(
                      valueListenable: headerNotifier,
                      builder: (context, header, _) {
                        return header == 0
                            ? YearHeader(
                                languageCode: widget.languageCode,
                                dropDownJPERaListener: dropDownJPERaListener)
                            : MonthHeader(
                                languageCode: widget.languageCode,
                                yearListener: selectedYearListener,
                                onPressed: () {
                                  _pageController.jumpToPage(0);
                                  headerNotifier.value = 0;
                                },
                                monthListener: monthListener,
                                monthSwitchController: _monthPageController);
                      }),
                  Divider(
                    height: 0,
                    color: Theme.of(context).dividerTheme.color,
                  ),
                  Flexible(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        ENJP.YearPicker(
                          initialValue: widget.initialValue,
                          jpEnYearNotifier: dropDownJPERaListener,
                          onYearChanged: (year) {
                            _pageController.jumpToPage(1);
                            headerNotifier.value = 1;
                            selectedYearListener.value = year;
                          },
                        ),
                        MonthPicker(
                          languageCode: widget.languageCode,
                          pageController: _monthPageController,
                          monthNotifier: monthListener,
                          yearNotifier: selectedYearListener,
                          dayTimeNotifier: dayTimeListener,
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: Theme.of(context).dividerTheme.color,
                  ),
                  CancelOkButton(
                    languageCode: widget.languageCode,
                    onSubmit: () {
                      if (dayTimeListener.value.isNotEmpty) {
                        if (headerNotifier.value == 1) {
                          widget.dateTimeCallback(getSelectedDateTime(
                              selectedYearListener.value,
                              dayTimeListener.value,
                              widget.languageCode));
                        }
                      }
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
