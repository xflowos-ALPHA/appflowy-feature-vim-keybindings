## 2025-05-14 - Vim Plugin Mode State Inconsistency in Read-Only Mode
**Vulnerability:** The Vim plugin allowed transitioning to 'Insert' mode even when the underlying `EditorState` was set to read-only (`editable = false`).
**Learning:** UI-level state machines (like Vim modes) must proactively synchronize with and respect the application's core permission/capability states to prevent deceptive UI states that imply editing is possible when it is not.
**Prevention:** Centralize state transitions through a validation layer (e.g., `_updateMode`) that checks global constraints (like `editable`) before applying state changes. Proactively verify these constraints on every external input (e.g., `onKey`).
