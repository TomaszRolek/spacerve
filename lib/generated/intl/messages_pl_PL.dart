// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl_PL locale. All the
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
  String get localeName => 'pl_PL';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "cant_be_empty":
            MessageLookupByLibrary.simpleMessage("Pole nie może zostać puste"),
        "do_not_have_account": MessageLookupByLibrary.simpleMessage(
            " Nie posiadasz jeszcze konta? "),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "error_occurred": MessageLookupByLibrary.simpleMessage("Wystąpił błąd"),
        "free_rooms": MessageLookupByLibrary.simpleMessage("Dostępne sale"),
        "invalid_email":
            MessageLookupByLibrary.simpleMessage("Podano nieprawidłowy email"),
        "invalid_pass": MessageLookupByLibrary.simpleMessage(
            "Hasło musi zawierać conajmniej 8 znaków"),
        "login": MessageLookupByLibrary.simpleMessage("Zaloguj się"),
        "login_error":
            MessageLookupByLibrary.simpleMessage("Podano nieprawidłowe dane"),
        "logout": MessageLookupByLibrary.simpleMessage("Wyloguj się"),
        "password": MessageLookupByLibrary.simpleMessage("Hasło"),
        "register": MessageLookupByLibrary.simpleMessage("Zarejestruj się"),
        "register_error": MessageLookupByLibrary.simpleMessage(
            "Wystąpił błąd podczas rejestracji"),
        "reservations": MessageLookupByLibrary.simpleMessage("Rezerwacje"),
        "reserve": MessageLookupByLibrary.simpleMessage("Rezerwuj"),
        "rooms": MessageLookupByLibrary.simpleMessage("Sale"),
        "scan": MessageLookupByLibrary.simpleMessage("Skanuj"),
        "welcome_desc": MessageLookupByLibrary.simpleMessage(
            "Rezerwuj swoją przestrzeń w wygodny sposób."),
        "your_reservations":
            MessageLookupByLibrary.simpleMessage("Twoje rezerwacje")
      };
}
