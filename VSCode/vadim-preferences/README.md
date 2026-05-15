# Vadim Light Theme

A clean, light theme ported from IntelliJ's Vadim Light color scheme, bundled with IntelliJ-style keybindings.

## Features

### 🎨 Theme
- **Vadim Light Color Scheme** — IntelliJ-inspired light theme
- Soft, readable colors optimized for extended coding sessions
- Consistent syntax highlighting across all languages
- Proper semantic token support for TypeScript, Rust, Go, and more

### ⌨️ Keybindings
67 custom keybindings from IntelliJ's GNOME keymap, including:

**Navigation**
- `alt+1` / `cmd+alt+1` / `ctrl+alt+1` — Project explorer
- `alt+7` / `f2` — Outline panel
- `shift+alt+left` / `ctrl+alt+left` — Navigate back
- `shift+alt+right` / `ctrl+alt+right` — Navigate forward

**Editing**
- `shift+alt+up/down` — Add cursor above/below
- `ctrl+m` / `capslock` — Reveal line / scroll to center
- `shift+ctrl+up/down` — Fold/unfold all

**Refactoring**
- `shift+ctrl+i` / `ctrl+alt+q` — Go to implementation
- `ctrl+b` — Reveal definition
- `shift+alt+7` / `alt+f7` — Find all references

**Splitting & Layout**
- `shift+ctrl+backquote` / `shift+ctrl+alt+enter` — Split editor right
- `shift+ctrl+f12` — Toggle zen mode
- `shift+alt+d` — Toggle maximized panel

**Debug** (Java/Android)
- `f10` / `shift+alt+f10` — Select & start debug
- `pause` / `shift+ctrl+alt+f9` — Hotswap (Java)

**Cross-Platform Support**
- All `cmd` shortcuts include `ctrl` alternatives for Windows/Linux
- Full Windows, macOS, and Linux support

## Installation

1. Install from VS Code Extensions marketplace: `Vadim Light`
2. Set as your active theme: `Preferences: Color Theme → Vadim Light`
3. Keybindings are automatically activated

## Customization

To override specific keybindings, add entries to your `keybindings.json`:

```json
[
  {
    "key": "ctrl+alt+1",
    "command": "your.custom.command",
    "when": "editorTextFocus"
  }
]
```

## Notes

- Some keybindings use IntelliJ command names (e.g., `intellij.action.Hotswap`) which map to VS Code equivalents
- Keybindings only apply when `editorTextFocus` is true (editor has focus)
- If conflicts occur with other extensions, keybindings can be modified in settings

## Credits

- Theme colors ported from JetBrains IntelliJ IDEA
- Keybindings from custom "Vadim (Gnome)" IntelliJ keymap
- VS Code conversion by vcaen

## License

MIT
