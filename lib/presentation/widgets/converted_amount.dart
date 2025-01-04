import 'package:Convertify/app_utils/app_strings.dart';
import 'package:Convertify/core/country_code_provider.dart';
import 'package:Convertify/l10n/app_localizations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConvertedAmount extends StatelessWidget {
  final double amount;
  final String fromCurrency;
  final String toCurrency;

  const ConvertedAmount({
    super.key,
    required this.amount,
    required this.fromCurrency,
    required this.toCurrency,
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
    final formattedAmount =
        NumberFormat.currency(symbol: toCurrency).format(amount);
    final countryCode = countryCodeProvider.getCountryCode(toCurrency);
    // final currencyCryptoProvider = Provider.of<CurrencyCryptoProvider>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context).translate('converted_amount'),
            style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
             getCurrencyImage(toCurrency, countryCode),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: AutoSizeText(
                  softWrap: true,
                  maxLines: 2,
                  formattedAmount,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}