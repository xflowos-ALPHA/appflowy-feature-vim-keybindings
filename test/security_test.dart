import 'package:flutter_test/flutter_test.dart';
import 'package:appflowy_feature_vim_keybindings/appflowy_feature_vim_keybindings.dart';
import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/services.dart';

void main() {
  test('Vim Plugin should not enter Insert mode if editor is read-only', () {
    final plugin = VimPlugin();
    final editorState = EditorState.blank();
    editorState.editable = false; // Set to read-only

    expect(plugin.mode, VimMode.normal);

    const iKey = KeyDownEvent(
      logicalKey: LogicalKeyboardKey.keyI,
      physicalKey: PhysicalKeyboardKey.keyI,
      timeStamp: Duration.zero,
    );

    plugin.onKey(editorState, iKey);

    // It should still be in normal mode because editor is read-only
    expect(plugin.mode, VimMode.normal);
  });

  test('Vim Plugin should revert to Normal mode if editor becomes read-only while in Insert mode', () {
    final plugin = VimPlugin();
    final editorState = EditorState.blank();
    editorState.editable = true;

    const iKey = KeyDownEvent(
      logicalKey: LogicalKeyboardKey.keyI,
      physicalKey: PhysicalKeyboardKey.keyI,
      timeStamp: Duration.zero,
    );

    plugin.onKey(editorState, iKey);
    expect(plugin.mode, VimMode.insert);

    editorState.editable = false;

    // Any key press should trigger a check and revert mode
    const anyKey = KeyDownEvent(
      logicalKey: LogicalKeyboardKey.keyA,
      physicalKey: PhysicalKeyboardKey.keyA,
      timeStamp: Duration.zero,
    );
    plugin.onKey(editorState, anyKey);

    expect(plugin.mode, VimMode.normal);
  });
}
