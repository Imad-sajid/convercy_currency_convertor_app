import 'package:Convertify/app_utils/app_colors.dart';
import 'package:Convertify/core/search_history_provider.dart';
import 'package:Convertify/l10n/app_localizations.dart';
import 'package:Convertify/presentation/widgets/search_history_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final searchHistoryProvider = Provider.of<SearchHistoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('search_history'),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                   AppColors.primaryColor
                ),
                foregroundColor: WidgetStateProperty.all(AppColors.white),
              ),
              onPressed: () {
                searchHistoryProvider.clearSearchHistory();
              },
              child: Text(
                AppLocalizations.of(context).translate('clear_history'),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SearchHistoryProvider>(
          builder: (context, searchHistoryProvider, _) =>
              searchHistoryProvider.searchHistory.isEmpty
                  ?  Center(child: Text(AppLocalizations.of(context).translate('noHistoryAvailable')))
                  : const SearchHistoryList(),
        ),
      ),
    );
  }
}
