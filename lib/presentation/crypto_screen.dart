// lib/presentation/screens/crypto_screen.dart

import 'package:Convertify/app_utils/app_colors.dart';
import 'package:Convertify/core/crypto_provider.dart';
import 'package:Convertify/core/search_history_provider.dart';
import 'package:Convertify/l10n/app_localizations.dart';
import 'package:Convertify/presentation/widgets/converted_amount.dart';
import 'package:Convertify/presentation/widgets/crypto_currency_selector.dart';
import 'package:Convertify/presentation/widgets/language_selector.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme_provider.dart';
import '../core/connectivity_provider.dart';
import 'widgets/currency_input.dart';
import 'widgets/currency_selector.dart';

class CryptoScreen extends StatelessWidget {
  const CryptoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivityProvider = Provider.of<ConnectivityProvider>(context);
    final cryptoProvider = Provider.of<CurrencyCryptoProvider>(context);

    return Scaffold(
      extendBody: true,
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
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
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'Crypto Conversion',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  centerTitle: true,
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
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
                                  child: CryptoCurrencySelector(
                                        selectedCurrency: cryptoProvider.fromCurrency,
                                        type: 'from',
                                        currencies: [
                                        //   ...provider.availableCurrencies,
                                          ...cryptoProvider.availableCryptoCurrencies
                                        ],
                                        onChanged: (value) {
                                          cryptoProvider.updateFromCurrency(value!);
                                        },                                      ),
                                ),
                                // IconButton(
                                //   icon: 
                                const Icon(Icons.compare_arrows_sharp,
                                      size: 20, color: Colors.blue),
                                //   onPressed: () {
                                //     // cryptoProvider.swapCurrencies();
                                //   },
                                // ),
                                Expanded(
                                  child: FiatCurrencySelector(
                                        selectedCurrency: cryptoProvider.toCurrency,
                                        currencies: [
                                          ...cryptoProvider.availableCurrencies,
                                          ...cryptoProvider.availableCryptoCurrencies

                                        ],
                                        type: 'to',
                                        onChanged: (value) {
                                          cryptoProvider.updateToCurrency(value!);
                                        },
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Currency Input Here
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Consumer<CurrencyCryptoProvider>(
                                builder: (context, provider, child) {
                                  return CurrencyInput(
                                    label: AppLocalizations.of(context)
                                        .translate('amountLabel'),
                                    controller: provider.amountController,
                                    onChanged: (value) {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
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
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 40),

                            ElevatedButton(
                              onPressed: () async {
                                if (!connectivityProvider.connectivityResults.contains(ConnectivityResult.none)) {
                            cryptoProvider.fetchConversionRate(
                              cryptoProvider.fromCurrency.toLowerCase(),
                              cryptoProvider.toCurrency.toLowerCase(),
                              true,
                            );

                            Provider.of<SearchHistoryProvider>(context, listen: false).saveSearch(
                              cryptoProvider.fromCurrency,
                              cryptoProvider.toCurrency,
                              cryptoProvider.amountController.text,
                              cryptoProvider.conversionRate,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppLocalizations.of(context).translate('noConnectivityMessage')),
                              ),
                            );
                          }
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  themeProvider.isDarkMode
                                      ? AppColors.black
                                      : AppColors.primaryColor,
                                ),
                                foregroundColor:
                                    WidgetStateProperty.all(AppColors.white),
                              ),
                              child: Text(AppLocalizations.of(context)
                                  .translate('convert')),
                            ),
                            //               ],
                            //             ),
                            //           ),

                            const SizedBox(height: 40),

                            // Consumer<CurrencyCryptoProvider>(
                            //   builder: (context, provider, child) {
                            //     if (provider.isLoading) {
                            //       return const CircularProgressIndicator();
                            //     } else if (provider.conversionRate != 0.0) {
                            //       final amount = _parseAmount(
                            //               provider.amountController.text) *
                            //           provider.conversionRate;
                            //       return Text(
                            //         '${provider.amountController.text} ${provider.fromCurrency} = $amount ${provider.toCurrency}',
                            //         style: const TextStyle(
                            //           fontSize: 18,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       );
                            //     } else {
                            //       return const SizedBox();
                            //     }
                            //   },
                            // ),
                            //          
                          ],
                        ),
                      ),
                const SizedBox(height: 40),

                       cryptoProvider.isLoading
                                          ? const CircularProgressIndicator()
                                          : cryptoProvider.conversionRate != 0.0
                                              ? ConvertedAmount(
                                                  amount: _parseAmount(cryptoProvider.amountController.text) * cryptoProvider.conversionRate,
                                                  fromCurrency: cryptoProvider.fromCurrency,
                                                  toCurrency: cryptoProvider.toCurrency,
                                                )
                                              : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  double _parseAmount(String amount) {
    return double.tryParse(amount) ?? 0.0;
  }
}
