<div align="center">
<img src="https://raw.githubusercontent.com/shunsui18/yozakura/refs/heads/main/resources/icons/icon-animated.svg" alt="Yozakura" width="80"/>

# 🌙 yozakura-yoru

**Yoru** *(夜 — night)* flavor of the [Yozakura](https://shunsui18.github.io/yozakura) yazi theme.  
Deep navy blues and moonlit backgrounds, softened with sakura petal accents.

[![Flavor](https://img.shields.io/badge/flavor-yoru-1a1b2e?style=flat-square&labelColor=ffb7c5&color=1a1b2e)](.)
[![yazi](https://img.shields.io/badge/yazi-0.4+-lavender?style=flat-square)](https://github.com/sxyazi/yazi)
[![Palette](https://img.shields.io/badge/palette-yozakura-ffb7c5?style=flat-square)](https://github.com/shunsui18/yozakura)

← [Back to main README](../README.md)
</div>

---

## ✦ Preview

<div align="center">
<img src="preview.png" alt="Yozakura Yoru — night flavor preview" width="800"/>
</div>

---

## ✦ Files

| File | Purpose |
|---|---|
| `flavor.toml` | Flavor metadata and color definitions |
| `theme.toml` | Full color theme (status bar, borders, selection, etc.) |
| `tmtheme.xml` | Syntax highlighting colors for file previews |
| `preview.png` | Preview screenshot |
| `LICENSE` | License for the theme |
| `LICENSE-tmtheme` | License for the tmtheme syntax file |

---

## ✦ Installation via `ya pkg`

Install this flavor directly through yazi's built-in package manager:

```bash
ya pkg add shunsui18/yozakura-yazi:yozakura-yoru
```

Then **manually activate** it by adding or updating the `[flavor]` block in your `~/.config/yazi/theme.toml`:

```toml
[flavor]
use = "yozakura-yoru"
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
