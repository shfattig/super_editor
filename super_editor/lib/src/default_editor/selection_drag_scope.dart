import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// Provides the drag-selection state of the nearest [DocumentMouseInteractor]
/// ancestor to descendant widgets (e.g. [TextComponent]) without explicit
/// parameter threading.
///
/// [DocumentMouseInteractor] wraps its content child with this scope and
/// flips [isDragging] to `true` when a selection drag begins and back to
/// `false` when the pointer is released ([DocumentMouseInteractor._onDragEnd]).
///
/// [TextComponent] subscribes to [isDragging] via [didChangeDependencies] so
/// it can immediately finalize deferred inline-marker reveal the moment the
/// mouse button is released, rather than waiting for the debounce timer.
class SelectionDragScope extends InheritedWidget {
  const SelectionDragScope({
    super.key,
    required this.isDragging,
    required super.child,
  });

  final ValueNotifier<bool> isDragging;

  /// Returns the [ValueNotifier] from the nearest [SelectionDragScope], or
  /// `null` if none is present (touch interactors, unit tests, etc.).
  static ValueNotifier<bool>? maybeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<SelectionDragScope>()?.isDragging;

  @override
  bool updateShouldNotify(SelectionDragScope old) => isDragging != old.isDragging;
}
