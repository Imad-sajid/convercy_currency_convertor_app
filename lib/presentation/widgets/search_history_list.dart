
import 'package:Convertify/core/search_history_provider.dart';
import 'package:Convertify/core/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchHistoryList extends StatelessWidget {
  const SearchHistoryList({super.key});

   
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final searchHistoryProvider = Provider.of<SearchHistoryProvider>(context);
  
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: searchHistoryProvider.searchHistory.length,
              itemBuilder: (context, index) {
                final search = searchHistoryProvider.searchHistory[index];
                final String fromCurrency = search['fromCurrency'];
                final String toCurrency = search['toCurrency'];
                final double amount = search['amount'];
                final String convertedAmount = search['convertedAmount'];
                final int timestamp = search['timestamp'];
                final String formattedTime = _formatTime(timestamp);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$fromCurrency to $toCurrency',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Amount: ${amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Amount: $convertedAmount $toCurrency',
                            style:  TextStyle(
                              fontSize: 20,
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formattedTime,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Icon(
                                Icons.access_time,
                                size: 14,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      
    );
  }
String _formatTime(int timestamp) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('hh:mm a').format(dateTime);
  }
 
}
