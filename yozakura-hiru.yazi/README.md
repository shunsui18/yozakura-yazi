<div align="center">

<img src="https://raw.githubusercontent.com/shunsui18/yozakura/refs/heads/main/resources/icons/icon-animated.svg" alt="Yozakura" width="80"/>

# ☀️ yozakura-hiru

**Hiru** *(昼 — day)* flavor of the [Yozakura](https://shunsui18.github.io/yozakura) yazi theme.  
A warm ivory canvas bathed in soft daylight, with gentle pastel tones throughout.

[![Flavor](https://img.shields.io/badge/flavor-hiru-fdf6e3?style=flat-square&labelColor=d4a0a0&color=6e5f5f)](.)
[![yazi](https://img.shields.io/badge/yazi-0.4+-lavender?style=flat-square)](https://github.com/sxyazi/yazi)
[![Palette](https://img.shields.io/badge/palette-yozakura-ffb7c5?style=flat-square)](https://github.com/shunsui18/yozakura)

← [Back to main README](../README.md)

</div>

---

## ✦ Preview

<div align="center">
<img src="../assets/yazi-hiru-preview.png" alt="Yozakura Hiru — day flavor preview" width="800"/>
</div>

---

## ✦ Files

| File | Purpose |
|---|---|
| `flavor.toml` | Flavor metadata and color definitions |
| `theme.toml` | Full color theme (status bar, borders, selection, etc.) |
| `tmtheme.xml` | Syntax highlighting colors for file previews |

---

## ✦ Installation via `ya pkg`

Install this flavor directly through yazi's built-in package manager:

```bash
ya pkg add shunsui18/yazi:yozakura-hiru
```

Then **manually activate** it by adding or updating the `[flavor]` block in your `~/.config/yazi/theme.toml`:

```toml
[flavor]
use = "yozakura-hiru"
```

> **Note:** `ya pkg` only installs the flavor files into `~/.config/yazi/flavours/`. It does not create or modify `theme.toml` — you must set the `[flavor]` block yourself.

---

## ✦ Full Icon Experience

The `ya pkg` method installs only the flavor colors. For the complete icon set (file-type icons styled in the Yozakura palette), copy the `[icon]` section from the repo's root [`theme.toml`](../theme.toml) into your `~/.config/yazi/theme.toml`.

Or skip the manual work entirely — the [one-liner installer](../README.md#method-1--one-liner-recommended) handles everything automatically.

---

## ✦ Other Installation Methods

For the one-liner installer, manual clone, or `theme.toml` drop-in approach, see the [main README](../README.md#-installation).

---

<div align="center">

crafted with 🌸 by [shunsui18](https://github.com/shunsui18)

</div>
