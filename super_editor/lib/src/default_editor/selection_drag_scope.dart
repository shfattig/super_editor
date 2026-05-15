import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Provides the pointer-down state of the nearest [DocumentMouseInteractor]
/// ancestor to descendant widgets (e.g. [TextComponent]) without explicit
/// parameter threading.
///
/// [DocumentMouseInteractor] wraps its content child with this scope and
/// flips [isPointerDown] to `true` on any pointer-down event and back to
/// `false` on pointer-up or pointer-cancel.
///
/// [TextComponent] subscribes to [isPointerDown] via [didChangeDependencies]:
/// - While `true`: all marker reveals are suppressed (no reflow during drag or
///   double-click selection).
/// - On transition to `false` (pointer-up): inline marker reveal is finalized
///   for any pending selection or cursor focus.
class SelectionDragScope extends InheritedWidget {
  const SelectionDragScope({
    super.key,
    required this.isPointerDown,
    required super.child,
  });

  final ValueNotifier<bool> isPointerDown;

  /// Returns the [ValueNotifier] from the nearest [SelectionDragScope], or
  /// `null` if none is present (touch interactors, unit tests, etc.).
  static ValueNotifier<bool>? maybeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<SelectionDragScope>()?.isPointerDown;

  @override
  bool updateShouldNotify(SelectionDragScope old) => isPointerDown != old.isPointerDown;
}
