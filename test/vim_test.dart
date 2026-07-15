import 'package:flutter_test/flutter_test.dart';
import 'package:appflowy_feature_vim_keybindings/appflowy_feature_vim_keybindings.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/services.dart';

void main() {
  test('Vim Plugin Mode Switch Test', () {
    final plugin = VimPlugin();
    expect(plugin.mode, VimMode.normal);

    const iKey = KeyDownEvent(
      logicalKey: LogicalKeyboardKey.keyI,
      physicalKey: PhysicalKeyboardKey.keyI,
      timeStamp: Duration.zero,
    );

    plugin.onKey(EditorState.blank(), iKey);
    expect(plugin.mode, VimMode.insert);

    const escKey = KeyDownEvent(
      logicalKey: LogicalKeyboardKey.escape,
      physicalKey: PhysicalKeyboardKey.escape,
      timeStamp: Duration.zero,
    );

    plugin.onKey(EditorState.blank(), escKey);
    expect(plugin.mode, VimMode.normal);
  });

  test('Vim Plugin should not switch to insert mode when editor is read-only', () {
    final plugin = VimPlugin();
    final editorState = EditorState.blank();
    editorState.editable = false; // Make it read-only

    const iKey = KeyDownEvent(
      logicalKey: LogicalKeyboardKey.keyI,
      physicalKey: PhysicalKeyboardKey.keyI,
      timeStamp: Duration.zero,
    );

    plugin.onKey(editorState, iKey);
    expect(plugin.mode, VimMode.normal); // Should stay in normal mode
  });

  test('Vim Plugin should revert to normal mode if editor becomes read-only', () {
    final plugin = VimPlugin();
    final editorState = EditorState.blank();

    const iKey = KeyDownEvent(
      logicalKey: LogicalKeyboardKey.keyI,
      physicalKey: PhysicalKeyboardKey.keyI,
      timeStamp: Duration.zero,
    );

    plugin.onKey(editorState, iKey);
    expect(plugin.mode, VimMode.insert);

    // Now make it read-only
    editorState.editable = false;

    // Send any key, it should revert to normal
    const anyKey = KeyDownEvent(
      logicalKey: LogicalKeyboardKey.keyH,
      physicalKey: PhysicalKeyboardKey.keyH,
      timeStamp: Duration.zero,
    );
    plugin.onKey(editorState, anyKey);
    expect(plugin.mode, VimMode.normal);
  });
}
