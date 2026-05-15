# Vadim Light Extension — Complete Setup

## Extension Structure

```
vadim-light-theme/
├── package.json                           # Extension manifest (theme + keybindings)
├── README.md                              # User documentation
├── CHANGELOG.md                           # Version history
├── .vscodeignore                          # Exclude files from package
├── themes/
│   └── vadim-light-color-theme.json      # Color scheme (62 KB)
└── keybindings/
    └── vadim-keybindings.json            # Reference copy (keybindings in package.json)
```

## What's Included

- **1 Color Theme:** Vadim Light (IntelliJ port)
- **67 Keybindings:** Full IntelliJ GNOME keymap
- **Cross-platform:** cmd/ctrl variants for macOS/Windows/Linux

## Publishing to VS Code Marketplace

### Prerequisites
```bash
npm install -g vsce  # VS Code Extension CLI
```

### Publish Steps

1. **Create Publisher Account** (one-time)
   ```bash
   vsce create-publisher <publisher-name>
   ```

2. **Login**
   ```bash
   vsce login <publisher-name>
   ```

3. **Package Extension**
   ```bash
   cd ~/.dotfiles/VSCode/vadim-light-theme
   vsce package
   ```
   Creates: `vadim-light-theme-1.0.0.vsix`

4. **Publish**
   ```bash
   vsce publish
   # Or publish a pre-packaged VSIX:
   vsce publish --packagePath ./vadim-light-theme-1.0.0.vsix
   ```

5. **Update Version** (for future releases)
   - Edit `package.json` version
   - Update `CHANGELOG.md`
   - Run `vsce publish` (auto-increments)

### Local Testing (Before Publishing)

```bash
# Copy to VS Code extensions directory
ln -s ~/.dotfiles/VSCode/vadim-light-theme \
  ~/.vscode/extensions/vadim-light-theme

# Reload VS Code (Ctrl+Shift+P > Developer: Reload Window)

# Verify:
# 1. Command Palette → Color Theme → Vadim Light
# 2. Try keybindings: Alt+1 (open explorer), Shift+Ctrl+I (go to implementation)
```

## For End Users

Once published, users can:

```bash
# Via CLI
code --install-extension vcaen.vadim-light-theme

# Via VS Code GUI
# Extensions → Search "Vadim Light" → Install
```

After install:
1. Settings → Color Theme → "Vadim Light"
2. Keybindings auto-activate
3. Open Command Palette (Shift+Ctrl+P) to search shortcuts

## Extension Metadata

| Field | Value |
|-------|-------|
| Name | `vadim-light-theme` |
| Display Name | `Vadim Light` |
| Publisher | `vcaen` |
| Version | `1.0.0` |
| Engine | VS Code `^1.70.0` |
| Categories | Themes, Keymaps |

## File Sizes (Approx.)

| File | Size |
|------|------|
| Color theme JSON | ~62 KB |
| Keybindings (in package.json) | ~12 KB |
| README | ~3 KB |
| VSIX package | ~30 KB |

## Next Steps

- [ ] Test locally in VS Code
- [ ] Verify all 67 keybindings work as expected
- [ ] Try theme colors across different file types
- [ ] Test on Windows/Linux/macOS if possible
- [ ] Create publisher account (one-time)
- [ ] Publish to marketplace
- [ ] Share extension URL with others

## Support

If keybindings conflict with other extensions:
- User can override in their `keybindings.json`
- Or disable specific bindings with `-` prefix

If colors don't look right:
- User can customize via `settings.json` with `workbench.colorCustomizations`
- Update theme file and republish as patch version

---

**Ready to publish?** Run:
```bash
cd ~/.dotfiles/VSCode/vadim-light-theme && vsce publish
```

All files included and ready to go! 🚀
