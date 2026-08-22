import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_editor/src/infrastructure/platforms/android/toolbar.dart';

void main() {
  group('AndroidTextEditingFloatingToolbar', () {
    testWidgets('omits the Create note button when the callback is null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AndroidTextEditingFloatingToolbar(
              onCopyPressed: _noop,
            ),
          ),
        ),
      );

      expect(find.text('Create note'), findsNothing);
      expect(find.text('Copy'), findsOneWidget);
    });

    testWidgets('shows the Create note button when the callback is provided', (tester) async {
      var pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AndroidTextEditingFloatingToolbar(
              onCreateNotePressed: () => pressed = true,
            ),
          ),
        ),
      );

      expect(find.text('Create note'), findsOneWidget);

      await tester.tap(find.text('Create note'));
      await tester.pump();

      expect(pressed, isTrue);
    });
  });
}

void _noop() {}
