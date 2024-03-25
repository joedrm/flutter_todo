// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/app.dart';

import 'package:flutter_todo/main.dart';
import 'package:leancloud_storage/leancloud.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // await tester.pumpWidget(App());

    // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);

    const arr1 = [1, 2, 3];
    const arr2 = [4, 5, 6];
    const arr3 = [7, 8, 9];
    const arr = [arr1, arr2, arr3];

    expect(arr.containsElement(2), true);

  });
}


extension FlattenFind<T extends Comparable> on Iterable<Iterable<T>> {
  bool containsElement(T value) {
    for (final arr in this) {
      if (arr.contains(value)) {
        return true;
      }
    }
    return false;
  }
}