// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "amountLabel": MessageLookupByLibrary.simpleMessage("Amount"),
        "amount_placeholder":
            MessageLookupByLibrary.simpleMessage("Enter amount"),
        "app_title": MessageLookupByLibrary.simpleMessage("Currency Converter"),
        "checkRates": MessageLookupByLibrary.simpleMessage("Check Rates"),
        "clear_history": MessageLookupByLibrary.simpleMessage("Clear History"),
        "converted_amount":
            MessageLookupByLibrary.simpleMessage("Converted Amount"),
        "enterValidAmount":
            MessageLookupByLibrary.simpleMessage("Please enter a valid amount"),
        "fromCurrencyLabel": MessageLookupByLibrary.simpleMessage("From"),
        "from_currency": MessageLookupByLibrary.simpleMessage("From"),
        "invalidInputOrRateZero": MessageLookupByLibrary.simpleMessage(
            "Invalid input or rate is zero"),
        "no_history":
            MessageLookupByLibrary.simpleMessage("No history available"),
        "search_history":
            MessageLookupByLibrary.simpleMessage("Search History"),
        "toCurrencyLabel": MessageLookupByLibrary.simpleMessage("To"),
        "to_currency": MessageLookupByLibrary.simpleMessage("To")
      };
}
