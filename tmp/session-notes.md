## Fix gutters.layout type

Changed line 52 in `dot-files/programs/.config/helix/config.toml` — converted `layout` from a TOML string to a TOML array:
- Before: `layout = "diff, diagnostics, line-numbers, marks"`
- After:  `layout = ["diff", "diagnostics", "line-numbers", "marks"]`

## Official Helix Config Reference

**Source**: https://docs.helix-editor.com/ (latest stable — tracked from `master` branch on GitHub)
**Version**: Latest stable release (docs.helix-editor.com). Bleeding-edge docs at https://docs.helix-editor.com/master.

### `[editor]` — Top-Level Keys

| Key | Type/Values | Default |
|---|---|---|
| `scrolloff` | integer | `5` |
| `mouse` | bool | `true` |
| `default-yank-register` | string | `"` |
| `middle-click-paste` | bool | `true` |
| `scroll-lines` | integer | `3` |
| `shell` | array of strings | `["sh", "-c"]` (Linux) / `["cmd", "/C"]` (Win) |
| `line-number` | `"absolute"` \| `"relative"` | `"absolute"` |
| `cursorline` | bool | `false` |
| `cursorcolumn` | bool | `false` |
| `continue-comments` | bool | `true` |
| `gutters` | array of strings | `["diagnostics", "spacer", "line-numbers", "spacer", "diff"]` |
| `auto-completion` | bool | `true` |
| `path-completion` | bool | `true` |
| `auto-format` | bool | `true` |
| `idle-timeout` | integer (ms) | `250` |
| `completion-timeout` | integer (ms) | `250` |
| `preview-completion-insert` | bool | `true` |
| `completion-trigger-len` | integer | `2` |
| `completion-replace` | bool | `false` |
| `auto-info` | bool | `true` |
| `true-color` | bool | `false` |
| `undercurl` | bool | `false` |
| `rulers` | array of integers | `[]` |
| `bufferline` | `"always"` \| `"never"` \| `"multiple"` | `"never"` |
| `color-modes` | bool | `false` |
| `text-width` | integer | `80` |
| `workspace-lsp-roots` | array of strings | `[]` |
| `default-line-ending` | `"native"` \| `"lf"` \| `"crlf"` \| `"ff"` \| `"cr"` \| `"nel"` | `"native"` |
| `insert-final-newline` | bool | `true` |
| `atomic-save` | bool | `true` |
| `trim-final-newlines` | bool | `false` |
| `trim-trailing-whitespace` | bool | `false` |
| `popup-border` | `"popup"` \| `"menu"` \| `"all"` \| `"none"` | `"none"` |
| `indent-heuristic` | `"simple"` \| `"tree-sitter"` \| `"hybrid"` | `"hybrid"` |
| `jump-label-alphabet` | string | `"abcdefghijklmnopqrstuvwxyz"` |
| `end-of-line-diagnostics` | `"disable"` \| `"hint"` \| `"info"` \| `"warning"` \| `"error"` | `"disable"` |
| `clipboard-provider` | string (platform-dependent) | auto-detected |
| `editor-config` | bool | `true` |

### `[editor.gutters]` — Layout Configuration

Valid gutter types: `"diagnostics"`, `"diff"`, `"line-numbers"`, `"spacer"`.

**IMPORTANT**: `"marks"` is **NOT** a valid gutter type. The existing config uses it — it will be silently ignored or cause a parse error.

**Array form** (simple):
```toml
[editor]
gutters = ["diff", "diagnostics", "line-numbers", "spacer"]
```

**Table form** (with sub-sections):
```toml
[editor.gutters]
layout = ["diff", "diagnostics", "line-numbers", "spacer"]

[editor.gutters.line-numbers]
min-width = 1

[editor.gutters.diagnostics]
# currently unused

[editor.gutters.diff]
# no options currently

[editor.gutters.spacer]
# currently unused
```

Default layout: `["diagnostics", "spacer", "line-numbers", "spacer", "diff"]`

### `[editor.statusline]` — Statusline Configuration

Three areas: `left`, `center`, `right` lists of elements.

**Default values**:
```toml
[editor.statusline]
left = ["mode", "spinner", "file-name", "read-only-indicator", "file-modification-indicator"]
center = []
right = ["diagnostics", "selections", "register", "position", "file-encoding"]
separator = "│"

mode.normal = "NOR"
mode.insert = "INS"
mode.select = "SEL"

diagnostics = ["warning", "error"]
workspace-diagnostics = ["warning", "error"]
```

**Available elements** for `left`/`center`/`right` lists:

| Element | Description |
|---|---|
| `mode` | Current mode (text from mode.normal/insert/select) |
| `spinner` | LSP activity spinner |
| `file-name` | Path/name of opened file |
| `file-absolute-path` | Absolute path |
| `file-base-name` | Basename only |
| `file-modification-indicator` | `[+]` when unsaved changes |
| `file-encoding` | Encoding if != UTF-8 |
| `file-line-ending` | CRLF or LF |
| `file-indent-style` | Indentation style |
| `read-only-indicator` | `[readonly]` when file is read-only |
| `total-line-numbers` | Total line count |
| `file-type` | File type |
| `diagnostics` | Count of warnings/errors |
| `workspace-diagnostics` | Workspace diagnostic count |
| `selections` | Selection index / total selections |
| `primary-selection-length` | Char count in primary selection |
| `position` | Cursor position |
| `position-percentage` | Cursor position as % of lines |
| `separator` | The separator character |
| `spacer` | Space between elements |
| `version-control` | Current branch / commit hash |
| `register` | Current selected register |

### `[editor.whitespace]` — Whitespace Rendering

```toml
[editor.whitespace]
render = "all"
# or control each character individually:
[editor.whitespace.render]
space = "all"
tab = "all"
nbsp = "none"
nnbsp = "none"
newline = "none"

[editor.whitespace.characters]
space = "·"
nbsp = "⍽"
nnbsp = "␣"
tab = "→"
newline = "⏎"
tabpad = "·"
```

- `render`: `"all"` \| `"none"` \| table with sub-keys `space`, `nbsp`, `nnbsp`, `tab`, `newline`
- `characters`: table with optional sub-keys `tab`, `space`, `nbsp`, `nnbsp`, `newline`, `tabpad`
- Use `:set whitespace.render all` to toggle on-the-fly.

### `[editor.lsp]` — LSP Configuration

| Key | Type | Default | Description |
|---|---|---|---|
| `enable` | bool | `true` | Master LSP toggle |
| `display-messages` | bool | `true` | Show `window/showMessage` below statusline |
| `display-progress-messages` | bool | `false` | Show LSP progress below statusline |
| `auto-signature-help` | bool | `true` | Auto-popup signature help |
| `display-inlay-hints` | bool | `false` | Display inlay hints |
| `inlay-hints-length-limit` | integer (positive) | unset | Max length of inlay hints |
| `display-color-swatches` | bool | `true` | Color swatches next to colors |
| `display-signature-help-docs` | bool | `true` | Docs under signature help popup |
| `snippets` | bool | `true` | Snippet completions (requires `:lsp-restart`) |
| `goto-reference-include-declaration` | bool | `true` | Include decl in goto refs |

### `[editor.cursor-shape]`

```toml
[editor.cursor-shape]
normal = "block"
insert = "bar"
select = "underline"
```
Valid values: `"block"`, `"bar"`, `"underline"`, `"hidden"`.

### Full Config Rewrite

The entire `dot-files/programs/.config/helix/config.toml` was overwritten (58 lines replaced) to fix multiple config errors:

1. **`[editor.gutters]` layout** — Removed invalid `"marks"` gutter type; replaced with `["diagnostics", "spacer", "line-numbers", "spacer", "diff"]` (matching the official default).

2. **`[editor.whitespace]`** — Split `render = true` (bool → string `"all"`) and moved `characters.*` keys into their own sub-table `[editor.whitespace.characters]` (was incorrectly nested as `characters.space`, etc.).

3. **`[editor.soft-wrap]`** — Converted from inline dotted keys under `[editor]` (`soft-wrap.enable = true`) to a proper TOML table `[editor.soft-wrap]`.

4. **`[editor.statusline]`** — Added the `diagnostics = ["warning", "error"]` sub-table to control which severities show.

5. **`[editor]` top-level** — Removed the two `soft-wrap.*` inline keys (superseded by the table form).

6. **`theme`** — Kept `"catppuccin_mocha"` (valid built-in).

All changes verified against the official Helix docs at https://docs.helix-editor.com/configuration.html.

## Default Theme Names (Built-in)

Themes shipped with Helix: viewable at https://github.com/helix-editor/helix/tree/master/runtime/themes

Common built-ins include:
- `catppuccin_mocha`, `catppuccin_latte`, `catppuccin_frappe`, `catppuccin_macchiato`
- `onedark`, `dracula`, `gruvbox`, `solarized_dark`, `solarized_light`
- `ayu_dark`, `ayu_light`, `ayu_mirage`
- `base16_default`, `default` (reserved names, cannot be overridden by user themes)

Use `:theme <name>` at runtime or `theme = "<name>"` in `config.toml`.

### Key Binding Format

From https://docs.helix-editor.com/keymap.html and https://docs.helix-editor.com/remapping.html:

Keys are remapped in sections by mode:
```toml
[keys.normal]
h = "move_char_left"
j = "move_visual_line_down"
k = "move_visual_line_up"
l = "move_char_right"

[keys.insert]
"Escape" = "normal_mode"

[keys.select]
# same keys as normal mode, extends selections
```

Modifier keys use hyphens: `"C-s"` = Ctrl+s, `"A-f"` = Alt+f, `"S-tab"` = Shift+Tab.

Use `"no_op"` to disable a keybinding.

Custom keybindings documentation is in the remapping chapter: https://docs.helix-editor.com/remapping.html
