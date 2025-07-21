import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

String getDate({required String? dateTime, int duration = 0}) {
  try {
    DateTime d = DateTime.parse(dateTime!).add(Duration(days: duration));
    return '${d.day}/${d.month}/${d.year}';
  } catch (e) {}
  return "NA";
}

String generateRandomString(int length) {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  Random random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
}

void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus(); // Unfocus input fields
  SystemChannels.textInput.invokeMethod('TextInput.hide'); // Hide keyboard

  // Kill the Windows on-screen keyboard process
  Process.run('taskkill', ['/IM', 'TabTip.exe', '/F']);
}

DateTime? parseAnyDate(String input) {
  print("date format $input");
  try {
    if (input.contains(':')) {
      // Contains time
      return DateFormat('dd-MM-yyyy HH:mm:ss').parse(input);
    } else {
      // Date only
      return DateFormat('dd-MM-yyyy').parse(input);
    }
  } catch (e) {
    print("Invalid Date format:$e");
    return null;
  }
}
