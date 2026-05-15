# IntelliJ → VS Code Keybindings Mapping

**Source:** `~/.dotfiles/intellij/Vadim _Gnome_.xml` (IntelliJ settings)  
**Updated:** `~/.dotfiles/VSCode/keybindings.json`  
**Date:** 2026-04-24

## Summary

Extracted and ported **67 custom shortcuts** from your IntelliJ "Vadim (Gnome)" keymap to VS Code.

### Key Conventions

- All shortcuts using `meta` (Super/Windows key) also get a `ctrl` variant for cross-platform consistency
- Shortcuts maintain the `editorTextFocus` condition where applicable  
- IntelliJ action IDs map to equivalent VS Code commands where possible

---

## Remapped Shortcuts (Cmd/Ctrl Duals)

| Shortcut | IntelliJ Action | VS Code Command | Notes |
|----------|-----------------|-----------------|-------|
| `alt+1` / `cmd+alt+1` / `ctrl+alt+1` | ActivateProjectToolWindow | workbench.view.explorer | Project explorer |
| `alt+7` / `f2` | ActivateStructureToolWindow | outline.focus | Outline panel |
| `alt+g` | Annotate | intellij.action.Annotate | Blame annotations |
| `alt+f7` / `shift+alt+7` | FindUsages | editor.action.referenceSearch.trigger | Find all references |
| `shift+alt+left` / `ctrl+alt+left` | Back | workbench.action.navigateBack | Navigate back |
| `shift+alt+right` / `ctrl+alt+right` | Forward | workbench.action.navigateForward | Navigate forward |

---

## Core Navigation & Editing

| Shortcut | Command | Action |
|----------|---------|--------|
| `ctrl+m` / `capslock` | revealLine | Reveal line / scroll to center |
| `ctrl+q` | editor.action.showHover | Show hover/docs |
| `f1` / `f2` / `ctrl+f12` | outline.focus | Open outline |
| `shift+ctrl+i` / `ctrl+alt+q` | editor.action.goToImplementation | Go to implementation |
| `ctrl+b` | editor.action.revealDefinition | Reveal definition |

---

## Folding

| Shortcut | Command | Action |
|----------|---------|--------|
| `shift+ctrl+subtract` / `shift+ctrl+minus` | editor.foldAll | Fold all |
| `ctrl+add` / `ctrl+equal` | editor.unfoldAll | Unfold all |
| `shift+ctrl+alt+up` | editor.foldAll | Fold all (alt) |
| `shift+ctrl+alt+down` | editor.unfoldAll | Unfold all (alt) |

---

## Splitting & Window Management

| Shortcut | Command | Action |
|----------|---------|--------|
| `shift+ctrl+backquote` / `shift+ctrl+alt+enter` / `shift+ctrl+semicolon` | workbench.action.splitEditorRight | Split editor right |
| `shift+ctrl+escape` / `shift+ctrl+alt+backspace` | workbench.action.closeEditorsInGroup | Close editor group |
| `shift+ctrl+f12` / `shift+ctrl+alt+g` | workbench.action.toggleZenMode | Toggle zen mode |
| `shift+ctrl+k` | workbench.action.toggleActivityBarVisibility | Toggle activity bar |

---

## Cursor & Multi-Cursor

| Shortcut | Command | Action |
|----------|---------|--------|
| `shift+alt+up` | editor.action.insertCursorAbove | Add cursor above |
| `shift+alt+down` | editor.action.insertCursorBelow | Add cursor below |
| `shift+alt+l` / `shift+alt+k` | editor.action.dirtydiff.next/previous | VCS diff markers |

---

## Debug & Testing

| Shortcut | Command | Action |
|----------|---------|--------|
| `f10` / `shift+alt+f10` | workbench.action.debug.selectandstart | Select & start debug |
| `pause` / `shift+ctrl+alt+f9` | intellij.action.Hotswap | Hotswap (Java debug) |
| `shift+alt+backquote` | intellij.action.StepOut | Step out |

---

## Debugging Helpers

| Shortcut | Command | Action |
|----------|---------|--------|
| `ctrl+alt+f10` | intellij.action.android.deploy.CodeSwap | Android code swap |
| `ctrl+f10` | intellij.action.android.deploy.ApplyChanges | Android apply changes |
| `shift+ctrl+f9` | intellij.action.AndroidConnectDebuggerAction | Android connect debugger |

---

## Other Actions

| Shortcut | Command | Action |
|----------|---------|--------|
| `shift+ctrl+alt+d` | intellij.action.DockPinnedMode | Dock pinned mode |
| `shift+ctrl+alt+w` | editor.action.toggleWordWrap | Toggle word wrap |
| `shift+alt+quote` | intellij.action.XDebugger.MuteBreakpoints | Mute breakpoints |
| `shift+alt+2` | intellij.action.ToggleInlineHintsAction | Toggle inline hints |
| `shift+alt+enter` | intellij.action.SwitchApply | Apply refactoring |
| `f12` / `shift+alt+equal` | intellij.action.JumpToLastWindow | Jump to last window |

---

## Installation

Your keybindings are already merged into `~/.dotfiles/VSCode/keybindings.json`. To use them:

```bash
# If you use VS Code with dotfiles symlinks:
ln -s ~/.dotfiles/VSCode ~/.config/Code/User

# Or copy to your VS Code config:
cp ~/.dotfiles/VSCode/keybindings.json ~/.config/Code/User/keybindings.json
```

---

## Notes

- Some IntelliJ actions (e.g., `Macro.debug system process`, `Git.ResolveConflicts`) don't have direct VS Code equivalents but are kept as placeholders
- VS Code uses different command names; mapped where reasonably equivalent
- `when` conditions ensure shortcuts don't interfere with other contexts
- Test conflicts with existing bindings — some may override VS Code defaults
