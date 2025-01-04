import 'package:Convertify/app_utils/app_colors.dart';
import 'package:Convertify/core/search_history_provider.dart';
import 'package:Convertify/l10n/app_localizations.dart';
import 'package:Convertify/presentation/crypto_screen.dart';
import 'package:Convertify/presentation/search_history_screen.dart';
import 'package:Convertify/presentation/widgets/language_selector.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/currency_provider.dart';
import '../core/theme_provider.dart';
import '../core/connectivity_provider.dart';
import 'widgets/converted_amount.dart';
import 'widgets/currency_input.dart';
import 'widgets/currency_selector.dart';

class StandardCurrencyScreen extends StatelessWidget {
  const StandardCurrencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using Consumer widgets to get providers
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);

    // List of screens for navigation
    final List<Widget> screens = [
      _buildHomeScreen(
          context, currencyProvider, themeProvider, connectivityProvider),
      const HistoryScreen(),
      const CryptoScreen(),
    ];
    // final size = SizeConfig().init(context);

    return Scaffold(
      extendBody: true,
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return IndexedStack(
            index: currencyProvider.currentIndex,
            // index: ,
            children: screens,
          );
        },
      ),
      bottomNavigationBar: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return AnimatedBottomNavigationBar(
            backgroundColor: themeProvider.isDarkMode
                ? AppColors.backgroundDarkColor
                : Colors.blue.shade500,
            icons: const [Icons.home, Icons.history, Icons.currency_bitcoin],
            inactiveColor:
                themeProvider.isDarkMode ? Colors.white : AppColors.black,
            activeColor: themeProvider.isDarkMode
                ? AppColors.primaryColor
                : AppColors.white,
            elevation: 5,
            activeIndex: currencyProvider.currentIndex,
            gapLocation: GapLocation.none,
            notchSmoothness: NotchSmoothness.sharpEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            onTap: (index) => currencyProvider.updateIndex(index),
          );
        },
      ),
    );
  }

  Widget _buildHomeScreen(
    BuildContext context,
    CurrencyProvider currencyProvider,
    ThemeProvider themeProvider,
    ConnectivityProvider connectivityProvider,
  ) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: themeProvider.isDarkMode
                ? const Color.fromARGB(255, 94, 92, 92)
                : AppColors.white,
          ),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            color: !themeProvider.isDarkMode
                ? AppColors.primaryColor
                : AppColors.secondaryTextColor,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: Text(
              AppLocalizations.of(context).translate('app_title'),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            actions: [
              Switch(
                value: themeProvider.isDarkMode,
                activeColor: const Color.fromARGB(255, 43, 237, 50),
                inactiveTrackColor: Colors.grey,
                thumbColor: WidgetStateProperty.all(Colors.white),
                onChanged: (value) {
                  _toggleTheme(context, value);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context).translate('checkRates'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    border: !themeProvider.isDarkMode
                        ? Border.all(
                            color: Colors.black.withOpacity(.2),
                            width: 1,
                          )
                        : Border.all(),
                    boxShadow: [
                      BoxShadow(
                        color: !themeProvider.isDarkMode
                            ? Colors.black.withOpacity(.2)
                            : Colors.white.withOpacity(.2),
                        offset: const Offset(0, 5),
                        blurRadius: 10,
                      ),
                    ],
                    color: AppColors.white,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: LanguageSelector(),
                      ),
                      const SizedBox(height: 20),

                      // Currency Selectors here
                      Row(
                        children: [
                          Expanded(
                            child: FiatCurrencySelector(
                              selectedCurrency: currencyProvider.fromCurrency,
                              currencies: currencyProvider.availableCurrencies,
                              onChanged: (value) {
                                currencyProvider.updateFromCurrency(value!);
                              },
                              type: 'from',
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.compare_arrows_sharp,
                                size: 24, color: Colors.blue),
                            onPressed: () {
                              currencyProvider.swapCurrencies();
                            },
                          ),
                          Expanded(
                            child: FiatCurrencySelector(
                              type: 'to',
                              selectedCurrency: currencyProvider.toCurrency,
                              currencies: currencyProvider.availableCurrencies,
                              onChanged: (value) {
                                currencyProvider.updateToCurrency(value!);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Currency Input Here
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: CurrencyInput(
                          label: AppLocalizations.of(context)
                              .translate('amountLabel'),
                          controller: currencyProvider.amountController,
                          onChanged: (value) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            if (value.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)
                                      .translate('enterValidAmount'),
                                ),
                              ));
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 40),

                      ElevatedButton(
                        onPressed: () {
                          if (!connectivityProvider.connectivityResults
                              .contains(ConnectivityResult.none)) {
                            currencyProvider.fetchConversionRate(
                              currencyProvider.fromCurrency.toLowerCase(),
                              currencyProvider.toCurrency.toLowerCase(),
                              true,
                            );

                            Provider.of<SearchHistoryProvider>(context,
                                    listen: false)
                                .saveSearch(
                              currencyProvider.fromCurrency,
                              currencyProvider.toCurrency,
                              currencyProvider.amountController.text,
                              currencyProvider.conversionRate,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppLocalizations.of(context)
                                    .translate('noConnectivityMessage')),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          //MAterialstateproperty has been deprecated, use widgetstateproperty
                          backgroundColor: WidgetStateProperty.all(
                            themeProvider.isDarkMode
                                ? AppColors.black
                                : AppColors.primaryColor,
                          ),
                          foregroundColor:
                              WidgetStateProperty.all(AppColors.white),
                        ),
                        child: Text(
                            AppLocalizations.of(context).translate('convert')),
                      ),
                    ],
                  ),
                ),

                // Results here, use shimmer effects.
                const SizedBox(height: 40),
                currencyProvider.isLoading
                    ? const CircularProgressIndicator()
                    : currencyProvider.conversionRate != 0.0
                        ? ConvertedAmount(
                            amount: _parseAmount(
                                    currencyProvider.amountController.text) *
                                currencyProvider.conversionRate,
                            fromCurrency: currencyProvider.fromCurrency,
                            toCurrency: currencyProvider.toCurrency,
                          )
                        : const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _toggleTheme(BuildContext context, bool isDarkMode) {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme(isDarkMode);
  }

  double _parseAmount(String amount) {
    return double.tryParse(amount) ?? 0.0;
  }
}
