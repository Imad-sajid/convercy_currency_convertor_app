// // models/currency_history_model.dart

// class CurrencyHistoryModel {
//   final DateTime date;
//   final double open;
//   final double high;
//   final double low;
//   final double close;

//   CurrencyHistoryModel({
//     required this.date,
//     required this.open,
//     // required this.high,
//     required this.low,
//     required this.close,
//   });

//   factory CurrencyHistoryModel.fromJson(Map<String, dynamic> json, String date) {
//     return CurrencyHistoryModel(
//       date: DateTime.parse(date),
//       open: double.parse(json["1. open"]),
//       high: double.parse(json["2. high"]),
//       low: double.parse(json["3. low"]),
//       close: double.parse(json["4. close"]),
//     );
//   }
// }
