import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class YearHeader extends StatelessWidget {
  final String languageCode;
  final ValueNotifier<String> dropDownJPERaListener;

  const YearHeader(
      {super.key,
      required this.dropDownJPERaListener,
      this.languageCode = "en"});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              dropDownJPERaListener.value = YearType.english;
            },
            child: Text(
              getCurrentYearMonth(languageCode),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                  ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: dropDownJPERaListener,
            builder: (context, jpEra, _) {
              return DropdownButton<dynamic>(
                value: jpEra.contains('english') ? null : jpEra,
                elevation: 1,
                hint: const Text("和暦"),
                underline: const SizedBox(),
                items: jpEraName.map((e) {
                  return DropdownMenuItem(
                    value: e.name,
                    child: Text(
                      e.type,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                          ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  dropDownJPERaListener.value = value as String;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
