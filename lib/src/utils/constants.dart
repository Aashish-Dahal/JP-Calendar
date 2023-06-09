// year and date Time callback function
typedef YearCallback = void Function(String year);
typedef DateTimeCallback = void Function(String dateTime);

enum CalendarType { EN, JP }

// Japanese and english year type
class YearType {
  static const String english = "english";
  static const String reiwa = "令和";
  static const String heisei = "平成";
  static const String showa = "昭和";
}

// Get Japanese and english year
class Year {
  final String year;
  final String type;

  Year(this.year, this.type);

  @override
  String toString() {
    switch (type) {
      case YearType.english:
        return year.toString();
      case YearType.showa:
        return year;
      case YearType.reiwa:
        return year;
      case YearType.heisei:
        return year;
      default:
        throw ArgumentError('Invalid YearType');
    }
  }
}

// Get List of japanese and english year
class YearFactory {
  static List<Year> getYears() {
    final now = DateTime.now().year;

    final englishYears = List.generate(
        now - 1926 + 1, (i) => Year("${i + 1950}", YearType.english));

    final showaYears = List.generate(1989 - 1927 + 1,
        (i) => Year("${i + 1926}-${YearType.showa} ${i + 1}", YearType.showa));

    final heiseiYears = List.generate(
        2019 - 1989 + 1,
        (i) =>
            Year("${i + 1989}-${YearType.heisei} ${i + 1}", YearType.heisei));

    final reiwaYears = List.generate(now - 2019 + 1,
        (i) => Year("${i + 2019}-${YearType.reiwa} ${i + 1}", YearType.reiwa));

    return [
      ...englishYears,
      ...showaYears,
      ...heiseiYears,
      ...reiwaYears,
    ];
  }

  static int getYearLength(String yearType) {
    switch (yearType) {
      case YearType.english:
        return YearFactory.getYears()
            .where((year) => year.type == YearType.english)
            .length;
      case YearType.reiwa:
        return YearFactory.getYears()
            .where((year) => year.type == YearType.reiwa)
            .length;
      case YearType.showa:
        return YearFactory.getYears()
            .where((year) => year.type == YearType.showa)
            .length;
      case YearType.heisei:
        return YearFactory.getYears()
            .where((year) => year.type == YearType.heisei)
            .length;
      default:
        return 0;
    }
  }
// Show english and japanese year value in calendar

  static String getYearValue(String yearType, int i) {
    switch (yearType) {
      case YearType.english:
        return YearFactory.getYears()
            .where((year) => year.type == YearType.english)
            .toList()[i]
            .toString();

      case YearType.showa:
        return YearFactory.getYears()
            .where((year) => year.type == YearType.showa)
            .toList()[i]
            .toString()
            .split("-")[1];

      case YearType.reiwa:
        return YearFactory.getYears()
            .where((year) => year.type == YearType.reiwa)
            .toList()[i]
            .toString()
            .split("-")[1];

      case YearType.heisei:
        return YearFactory.getYears()
            .where((year) => year.type == YearType.heisei)
            .toList()[i]
            .toString()
            .split("-")[1];

      default:
        throw ArgumentError('Invalid YearType');
    }
  }

  static String getSelectedYearValue(String yearType, int i) {
    switch (yearType) {
      case YearType.english:
        return YearFactory.getYears()
            .where((year) => year.type == YearType.english)
            .toList()[i]
            .toString();

      case YearType.showa:
        return YearFactory.getYears()
            .where((year) => year.type == YearType.showa)
            .toList()[i]
            .toString();

      case YearType.reiwa:
        return YearFactory.getYears()
            .where((year) => year.type == YearType.reiwa)
            .toList()[i]
            .toString();

      case YearType.heisei:
        return YearFactory.getYears()
            .where((year) => year.type == YearType.heisei)
            .toList()[i]
            .toString();

      default:
        throw ArgumentError('Invalid YearType');
    }
  }

  static int getSelectedYearIndex(String year, CalendarType type,
      [String? languageCode]) {
    String yearType = getDropDownInitialValue(year, type);
    String splitYear;
    if (languageCode == "en") {
      splitYear = year.split("-")[0];
    } else {
      splitYear = year.split("年")[0];
    }
    final yearList = YearFactory.getYears().where((y) {
      return y.type == yearType;
    }).toList();
    return yearList.indexWhere((y) => y.year.contains(splitYear));
  }
}

// Get total days in month
int daysInMonth(int monthIndex) {
  switch (monthIndex) {
    case 0:
    case 2:
    case 4:
    case 6:
    case 7:
    case 9:
    case 11:
      return 31;
    case 1:
      return DateTime.now().year % 4 == 0 ? 29 : 28;
    default:
      return 30;
  }
}

// current dateTime
int currentMonth = DateTime.now().month;
int currentYear = DateTime.now().year;
int currentDay = DateTime.now().day;
int weekDay = DateTime.now().weekday;

// Japanese Era type and name class
class JpEra {
  final String name;
  final String type;

  JpEra({required this.name, required this.type});

  @override
  String toString() {
    return name;
  }
}

// List of Japanese Era year name and type
List<JpEra> jpEraName = [
  JpEra(name: "令和", type: YearType.reiwa),
  JpEra(name: "平成", type: YearType.heisei),
  JpEra(name: "昭和", type: YearType.showa)
];

// Names of the days of the week
class DayMonth {
  final String name;
  final int id;
  DayMonth({required this.name, required this.id});
  @override
  String toString() {
    return name;
  }
}
// Name of List of the days of the week

List<DayMonth> days = [
  DayMonth(name: "Sun", id: 1),
  DayMonth(name: "Mon", id: 2),
  DayMonth(name: "Tue", id: 3),
  DayMonth(name: "Wed", id: 4),
  DayMonth(name: "Thu", id: 5),
  DayMonth(name: "Fri", id: 6),
  DayMonth(name: "Sat", id: 7),
];
// Name of List of the days of the week

List<DayMonth> jpDays = [
  DayMonth(name: "日", id: 1),
  DayMonth(name: "月", id: 2),
  DayMonth(name: "火", id: 3),
  DayMonth(name: "水", id: 4),
  DayMonth(name: "木", id: 5),
  DayMonth(name: "金", id: 6),
  DayMonth(name: "土", id: 7),
];

extension DateTimeExtension on DateTime {
  String? weekdayName() {
    Map<int, String> weekdayName = {
      1: "Mon",
      2: "Tue",
      3: "Wed",
      4: "Thu",
      5: "Fri",
      6: "Sat",
      7: "Sun"
    };
    return weekdayName[weekday];
  }

  String? jpWeekdayName() {
    Map<int, String> weekdayName = {
      1: "月",
      2: "火",
      3: "水",
      4: "木",
      5: "金",
      6: "土",
      7: "日"
    };
    return weekdayName[weekday];
  }
}

String getDayName(int id) {
  return days.firstWhere((day) => day.id == id).name;
}

String getJPDayName(int id) {
  return jpDays.firstWhere((day) => day.id == id).name;
}

// Returns the weekDay of the given day
int getWeekDay(int day) {
  int weekDay = (day + 1) % 7;
  if (weekDay == 0) {
    return 7;
  }
  return weekDay;
}

/// Returns the starting weekday of the given month

int getStartingWeekday(int year, int month) {
  DateTime firstDayOfMonth = DateTime(year, month, 1);
  return (firstDayOfMonth.weekday + 1) % 7;
}

//Returns calendar day of the starting day
int getCalendarDate(int startingDay, int i) {
  switch (startingDay) {
    case 1:
      return (i + 1);
    case 0:
      return (i - 5);
    default:
      return (i - startingDay + 2);
  }
}

// List of months
List<DayMonth> months = [
  DayMonth(name: 'January', id: 1),
  DayMonth(name: 'February', id: 2),
  DayMonth(name: 'March', id: 3),
  DayMonth(name: 'April', id: 4),
  DayMonth(name: 'May', id: 5),
  DayMonth(name: 'June', id: 6),
  DayMonth(name: 'July', id: 7),
  DayMonth(name: 'August', id: 8),
  DayMonth(name: 'September', id: 9),
  DayMonth(name: 'October', id: 10),
  DayMonth(name: 'November', id: 11),
  DayMonth(name: 'December', id: 12),
];
String getMonthName(int id) {
  return months.firstWhere((day) => day.id == id).name.substring(0, 3);
}

String getSelectedDateTime(String year, List dateTime, [String? languageCode]) {
  String splitYear = year;
  if (year.contains("-")) {
    splitYear = year.split("-")[1];
  }
  if (languageCode == "ja" || year.contains("-")) {
    return "$splitYear年${dateTime[1]}月${dateTime[0]}日";
  }

  return "$splitYear-${dateTime[1]}-${dateTime[0]}";
}

String getSelectedYearMonth(String year, int month, [String? languageCode]) {
  final splitYear = year.split("-").last;
  if (languageCode == "ja") {
    return "$splitYear年${month + 1}月";
  }
  return "${months[month]},$splitYear";
}

String getSelectedYearMonthDay(List dateTime, [String? languageCode]) {
  if (dateTime.isEmpty) {
    if (languageCode == "ja") {
      return "$currentMonth月$currentDay日(${DateTime.now().jpWeekdayName()})";
    } else {
      return "${DateTime.now().weekdayName()}, ${getMonthName(currentMonth)} $currentDay";
    }
  }
  if (languageCode == "ja") {
    return "${dateTime[1]}月${dateTime[0]}日(${getJPDayName(dateTime[2])})";
  }
  return "${getDayName(dateTime[2])}, ${getMonthName(dateTime[1])} ${dateTime[0]}";
}

String getCurrentYearMonth([String? languageCode]) {
  return languageCode == "ja"
      ? "$currentYear年$currentMonth月"
      : "${getMonthName(currentMonth)}, ${DateTime.now().year.toString()}";
}

String getDropDownInitialValue(String dropDownItems, CalendarType type) {
  if (dropDownItems.isEmpty) {
    YearType.english;
  } else if (dropDownItems.contains("-") && type == CalendarType.JP) {
    String jpDate = JPDateFormatter.parseToJPEra(dropDownItems);
    return jpDate.split(" ")[0];
  } else if (dropDownItems.contains(" ")) {
    return dropDownItems.split(" ")[0];
  }
  return YearType.english;
}

class JPDateFormatter {
  static String parseToJPEra(String dateStr) {
    DateTime date = DateTime.parse(dateStr);
    int year = date.year;
    int month = date.month;
    int day = date.day;
    String era = "";
    String eraYearStr = "";
    int eraYear = 0;

    if (year >= 2019) {
      era = "令和";
      eraYear = year - 2018;
    } else if (year >= 1989) {
      era = "平成";
      eraYear = year - 1988;
    } else if (year >= 1927) {
      era = "昭和";
      eraYear = year - 1925;
    } else if (year >= 1912) {
      era = "大正";
      eraYear = year - 1911;
    } else if (year >= 1868) {
      era = "明治";
      eraYear = year - 1867;
    }

    if (eraYear > 0) {
      if (eraYear == 1) {
        eraYearStr = "1";
      } else {
        eraYearStr = eraYear.toString();
      }
      return "$era $eraYearStr年$month月$day日";
    } else {
      return dateStr;
    }
  }

  static String parseToGregorian(String japaneseEraDate) {
    List<String> parts =
        japaneseEraDate.replaceAll(" ", "").split(RegExp(r'(?<=\D)(?=\d)'));
    int startYear;
    switch (parts[0]) {
      case '明治':
        startYear = 1868;
        break;
      case '大正':
        startYear = 1912;
        break;
      case '昭和':
        startYear = 1926;
        break;
      case '平成':
        startYear = 1989;
        break;
      case '令和':
        startYear = 2019;
        break;
      default:
        throw const FormatException('Invalid era name');
    }
    // Convert the year/month/day parts to integers
    int eraYear = int.parse(parts[1].split(RegExp(r'[年]'))[0]);
    int month = int.parse(parts[2].split(RegExp(r'[月]'))[0]);
    int day = int.parse(parts[3].split(RegExp(r'[日]'))[0]);
    // Calculate the corresponding Gregorian year
    int gregorianYear = startYear + eraYear - 1;
    // Format the result as a string in the YYYY/MM/DD format
    return '$gregorianYear-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }
}
