# Sentinel's Journal

## 2025-05-14 - Initializing Sentinel's Journal
**Vulnerability:** N/A
**Learning:** Initializing the journal for the first time in this repository.
**Prevention:** N/A

## 2025-05-14 - Respecting Editor Read-Only State in Vim Plugin
**Vulnerability:** Vim plugin allowed entering Insert mode even when the underlying EditorState was set to read-only. This could lead to unauthorized document modifications or UI state inconsistency where the user thinks they can edit but shouldn't be able to.
**Learning:** The Vim plugin's internal state machine was independent of the `EditorState.editable` flag. Document security/integrity should be enforced at all layers, including the input handling layer.
**Prevention:** Centralize all mode transitions through a validation method (e.g., `_updateMode`) that checks the `editable` status of the editor before allowing transitions to "Insert" or other editing modes. Additionally, proactively check this state on every key event to revert to "Normal" mode if the editor's permissions change.
