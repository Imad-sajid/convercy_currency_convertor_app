// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:Convertify/core/currency_history_provider.dart';
// import 'package:Convertify/models/currency_history_model.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class CurrencyHistoryWidget extends StatelessWidget {
//   final String fromCurrency;
//   final String toCurrency;

//   CurrencyHistoryWidget({required this.fromCurrency, required this.toCurrency});

//   @override
//   Widget build(BuildContext context) {
//     final currencyHistoryProvider =
//         Provider.of<CurrencyHistoryProvider>(context);

//     return Scaffold(
//       body: Column(
//         children: [
//           //elevated button that will get data on click
//           ElevatedButton(
//             onPressed: () {
//               currencyHistoryProvider.fetchCurrencyHistory(fromCurrency, toCurrency);
//             },
//             child: Text('Get Data'),
//           ),
//           if (currencyHistoryProvider.isLoading)
//             Center(child: CircularProgressIndicator())
//           else if (currencyHistoryProvider.currencyHistory.isEmpty)
//             Center(child: Text('No data available'))
//           else
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SfCartesianChart(
//                 primaryXAxis: DateTimeAxis(),
//                 title: ChartTitle(text: '$fromCurrency to $toCurrency Monthly Data'),
//                 legend: Legend(isVisible: true),
//                 tooltipBehavior: TooltipBehavior(enable: true),
//                 series: [
//                   LineSeries<CurrencyHistoryModel, DateTime>(
//                     dataSource: currencyHistoryProvider.currencyHistory,
//                     xValueMapper: (CurrencyHistoryModel data, _) => data.date,
//                     yValueMapper: (CurrencyHistoryModel data, _) => data.close,
//                     name: '$fromCurrency to $toCurrency',
//                     dataLabelSettings: DataLabelSettings(isVisible: true),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
