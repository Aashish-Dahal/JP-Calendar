import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../utils/constants.dart';
import '../widgets/day_year_button.dart';

final selectedYearNotifier = ValueNotifier<int>(-1);

class YearPicker extends StatefulWidget {
  final String initialYear;
  final String initialYearType;
  final YearCallback onYearChanged;
  final ValueNotifier<String> jpEnYearNotifier;

  const YearPicker({
    super.key,
    required this.jpEnYearNotifier,
    required this.onYearChanged,
    this.initialYear = "",
    this.initialYearType = YearType.english,
  });

  @override
  State<YearPicker> createState() => _YearPickerState();
}

class _YearPickerState extends State<YearPicker> {
  late final AutoScrollController _scrollController;

  @override
  void initState() {
    if (widget.initialYear.isNotEmpty) {
      int index = YearFactory.getSelectedYearIndex(
          widget.initialYear, widget.initialYearType);
      _scrollController.scrollToIndex(index);
    }
    _scrollController = AutoScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: widget.jpEnYearNotifier,
            builder: (context, yearType, _) {
              return GridView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                shrinkWrap: true,
                itemCount: YearFactory.getYearLength(yearType),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 3.2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (context, i) {
                  return AutoScrollTag(
                    key: ValueKey(i),
                    controller: _scrollController,
                    index: i,
                    child: ValueListenableBuilder(
                      valueListenable: selectedYearNotifier,
                      builder: (context, selectedYear, child) {
                        return DayYearButton(
                            isSelected: selectedYear == i,
                            onPressed: () {
                              selectedYearNotifier.value = i;
                              widget.onYearChanged(
                                  YearFactory.getSelectedYearValue(
                                      yearType, i));
                            },
                            title: YearFactory.getYearValue(yearType, i));
                      },
                    ),
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
