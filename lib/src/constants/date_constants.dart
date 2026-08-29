import '../date_controller.dart' show DateController;

/// Enum for [DateController]'s month format values.
enum Month {
  /// January.
  january(threeAbv: "jan", twoAbv: "ja"),

  /// February.
  february(threeAbv: "feb", twoAbv: "fe"),

  /// March.
  march(threeAbv: "mar", twoAbv: "mr"),

  /// April.
  april(threeAbv: "apr", twoAbv: "ap"),

  /// May.
  may(threeAbv: "may", twoAbv: "my"),

  /// June.
  june(threeAbv: "jun", twoAbv: "jn"),

  /// July.
  july(threeAbv: "jul", twoAbv: "jl"),

  /// August.
  august(threeAbv: "aug", twoAbv: "au"),

  /// September.
  september(threeAbv: "sep", twoAbv: "se"),

  /// October.
  october(threeAbv: "oct", twoAbv: "oc"),

  /// November.
  november(threeAbv: "nov", twoAbv: "nv"),

  /// December.
  december(threeAbv: "dec", twoAbv: "de");

  /// Three-letter abbreviation, e.g. "jan".
  final String threeAbv;

  /// Two-letter abbreviation, e.g. "ja".
  final String twoAbv;

  const Month({
    required this.threeAbv,
    required this.twoAbv,
  });
}

/// Enum for [DateController]'s month formats.
enum MonthFormat {
  /// Full month name, e.g. "January".
  full,

  /// Three-letter abbreviation, e.g. "Jan".
  threeLetters,

  /// Two-letter abbreviation, e.g. "Ja".
  twoLetters,
}

/// Enum for the column order of the day, month, and year scroll wheels.
enum DatePickerColumn {
  /// The day-of-month wheel.
  day,

  /// The month wheel.
  month,

  /// The year wheel.
  year,
}

/// Default value of [DateController]'s start date.
const String defaultStartDate = "1900-01-01 00:00:00";

/// Default value of [DateController]'s last date.
const String defaultLastDate = "2100-12-31 23:59:59";
