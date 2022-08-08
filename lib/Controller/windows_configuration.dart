import 'package:flutter/material.dart';
import 'package:flutter_window_close/flutter_window_close.dart';


class WindowsConfiguration{
  exit(BuildContext context) {
    FlutterWindowClose.setWindowShouldCloseHandler(() async {
      return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                backgroundColor: const Color.fromARGB(255, 125, 155, 156),
                title: const Text('Do you really want to Exit?'),
                actions: [
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 27, 44, 46))),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Yes')),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 27, 44, 46))),
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('No')),
                ]);
          });
    });
  }
}

