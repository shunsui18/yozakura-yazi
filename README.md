<div align="center">

<img src="https://raw.githubusercontent.com/shunsui18/yozakura/refs/heads/main/resources/icons/icon-animated.svg" alt="Yozakura" width="100"/>

# 夜桜 Yozakura — yazi Theme

A handcrafted pastel color palette for [yazi](https://github.com/sxyazi/yazi), based on the [Yozakura](https://shunsui18.github.io/yozakura) palette.

[![License: MIT](https://img.shields.io/badge/License-MIT-pink?style=flat-square)](LICENSE)
[![yazi](https://img.shields.io/badge/yazi-0.4+-lavender?style=flat-square)](https://github.com/sxyazi/yazi)
[![Shell](https://img.shields.io/badge/shell-bash-89b4fa?style=flat-square&logo=gnubash&logoColor=white)](install.sh)
[![Palette](https://img.shields.io/badge/palette-yozakura-ffb7c5?style=flat-square)](https://github.com/shunsui18/yozakura)

</div>

---

## ✦ Flavors

| | Flavor | Description |
|---|---|---|
| 🌙 | **Yoru** *(night)* | Deep, moonlit background with soft sakura accents |
| ☀️ | **Hiru** *(day)* | Warm ivory canvas with gentle pastel tones |

---

## ✦ Previews

<table>
<tr>
<td align="center"><b>🌙 Yoru</b></td>
<td align="center"><b>☀️ Hiru</b></td>
</tr>
<tr>
<td><img src="assets/yazi-yoru-preview.png" alt="Yoru — night flavor"/></td>
<td><img src="assets/yazi-hiru-preview.png" alt="Hiru — day flavor"/></td>
</tr>
</table>

---

## ✦ Installation

### Method 1 — One-liner (recommended)

Install directly from this repository with a single command:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/shunsui18/yazi/main/install.sh)
```

> Running without flags launches an **interactive menu** to pick your flavor.

---

### Options

| Flag | Values | Description |
|---|---|---|
| `--theme` | `yoru` \| `hiru` | Skip the menu and activate a specific flavor directly |
| `--no-backup` | — | Skip backing up your existing `theme.toml` |
| `-h`, `--help` | — | Show help and list available flavors |

---

### Examples

```bash
# interactive menu
bash <(curl -fsSL https://raw.githubusercontent.com/shunsui18/yazi/main/install.sh)

# skip menu — yoru (night)
bash <(curl -fsSL https://raw.githubusercontent.com/shunsui18/yazi/main/install.sh) --theme yoru

# skip menu — hiru (day)
bash <(curl -fsSL https://raw.githubusercontent.com/shunsui18/yazi/main/install.sh) --theme hiru
```

---

### Method 2 — `ya pkg` (manual theme activation)

You can install the flavor directly via yazi's package manager:

```bash
# yoru (night)
ya pkg add shunsui18/yazi:yozakura-yoru

# hiru (day)
ya pkg add shunsui18/yazi:yozakura-hiru
```

After installing, you need to **manually activate** the flavor by editing your `~/.config/yazi/theme.toml`:

```toml
[flavor]
use = "yozakura-yoru"   # or "yozakura-hiru" for the day flavor
```

> **Note:** The `ya pkg` method only installs the flavor files. It does not create a `theme.toml` for you — you must add or update the `[flavor]` block yourself.

---

### Method 3 — Manual Installation

If you prefer to install by hand:

```bash
# 1. Clone the repo
git clone https://github.com/shunsui18/yazi.git && cd yazi

# 2a. Interactive menu
bash install.sh

# 2b. Or pass a flavor directly
bash install.sh --theme yoru
```

---

## ✦ What the Installer Does

1. **Self-locates** — resolves its own path; in remote mode fetches all theme files from GitHub into a temp directory automatically
2. **Prompts** — shows an interactive flavor menu if no `--theme` flag is given; accepts a number or flavor name
3. **Validates** — confirms the requested flavor's files exist before touching anything
4. **Backs up** your existing `~/.config/yazi/theme.toml` (timestamped) before making any changes — pass `--no-backup` to skip
5. **Creates** the full directory tree under `$HOME/.config/yazi/` if not already present
6. **Copies** all flavor files into `~/.config/yazi/flavors/`:
   - `flavor.toml` — flavor metadata
   - `theme.toml` — full color theme
   - `tmtheme.xml` — syntax highlighting colors
7. **Symlinks** the active flavor — `theme.toml` points to the chosen variant, making flavor-switching a single re-run away
8. **Fails gracefully** — descriptive error messages if arguments are wrong or files are missing

---

## ✦ File Structure

```
yazi/
├── assets/
│   ├── yazi-yoru-preview.png
│   └── yazi-hiru-preview.png
├── flavors/
│   ├── yozakura-yoru.yazi/
│   │   ├── flavor.toml
│   │   ├── theme.toml
│   │   └── tmtheme.xml
│   └── yozakura-hiru.yazi/
│       ├── flavor.toml
│       ├── theme.toml
│       └── tmtheme.xml
├── theme.toml  →  flavors/yozakura-yoru.yazi/theme.toml  (symlink, active flavor)
├── install.sh
├── LICENSE
└── README.md
```

---

<div align="center">

crafted with 🌸 by [shunsui18](https://github.com/shunsui18)

</div>
