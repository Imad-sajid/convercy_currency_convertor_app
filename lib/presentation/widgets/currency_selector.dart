import 'package:Convertify/app_utils/app_colors.dart';
import 'package:Convertify/app_utils/app_strings.dart';
import 'package:Convertify/core/country_code_provider.dart';
import 'package:Convertify/core/theme_provider.dart';
import 'package:Convertify/l10n/app_localizations.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiatCurrencySelector extends StatelessWidget {
  final String selectedCurrency;
  final List<String> currencies;
  final ValueChanged<String?>? onChanged;
  final String type;

  const FiatCurrencySelector({
    super.key,
    required this.selectedCurrency,
    required this.currencies,
    this.onChanged,
    required this.type,
  });

  Widget getCurrencyImage(String currency, String countryCode) {
    const cryptoImages = {
      'ADA': AppStrings.ada,
      'BAT': AppStrings.ada,
      'BCH': AppStrings.bch,
      'BNT': AppStrings.bnt,
      'BTC': AppStrings.btc,
      'BTG': AppStrings.btg,
      'DASH': AppStrings.dash,
      'DOT': AppStrings.dot,
      'EOS': AppStrings.eos,
      'ETC': AppStrings.etc,
      'ETH': AppStrings.eth,
      'IOTA': AppStrings.iota,
      'LINK': AppStrings.link,
      'LTC': AppStrings.ltc,
      'NEO': AppStrings.neo,
      'QTUM': AppStrings.qtum,
      'TRC': AppStrings.trc,
      'USDT': AppStrings.usdt,
      'XRP': AppStrings.xrp,
      'XLM': AppStrings.xlm,

      // Add other cryptocurrencies and their images here
    };

    if (cryptoImages.containsKey(currency)) {
      return Image.asset(
        cryptoImages[currency]!,
        height: 25,
        width: 25,
        fit: BoxFit.fill,
      );
    } else {
      return Flag.fromString(
        countryCode,
        height: 25,
        width: 35,
        fit: BoxFit.fill,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final countryCodeProvider = Provider.of<CountryCodeProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    // final cryptoProvider = Provider.of<CurrencyCryptoProvider>(context);
    return Column(
      children: [
        Text(
          type == 'to'
              ? AppLocalizations.of(context).translate('toCurrencyLabel')
              : AppLocalizations.of(context).translate('fromCurrencyLabel'),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: .5, color: Colors.blue),
          ),
          child: DropdownButton<String>(
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: themeProvider.isDarkMode
                    ? AppColors.black
                    : AppColors.primaryColor),

            value: selectedCurrency,
            underline: Container(color: Colors.transparent),
            icon: Icon(
              Icons.arrow_drop_down,
              color: themeProvider.isDarkMode ? Colors.blue : AppColors.black,
            ), // Icon for the dropdown button

            items: currencies.map((currency) {
              String countryCode = countryCodeProvider.getCountryCode(currency);
              final themeProvider = Provider.of<ThemeProvider>(context);
              return DropdownMenuItem<String>(
                value: currency,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: getCurrencyImage(currency, countryCode),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left:8.0),
                    //   child: Flag.fromString(
                    //     countryCode,
                    //     height: 18,
                    //     width: 25,
                    //     fit: BoxFit.fill,
                    //   ),
                    // ),
                    const SizedBox(width: 10),
                    Text(
                      currency,
                      style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.black
                              : Colors.blue),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
