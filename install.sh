#!/usr/bin/env bash
# ╔══════════════════════════════════════════════════════════════╗
# ║   yozakura — yazi theme installer                            ║
# ║   Usage: bash install.sh [--theme <flavor>] [--no-backup]   ║
# ║          bash install.sh          (interactive menu)         ║
# ╚══════════════════════════════════════════════════════════════╝
set -euo pipefail

# ── ANSI palette ─────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
PINK='\033[38;5;218m'
LAVENDER='\033[38;5;147m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

info()    { echo -e "${CYAN}  →${RESET}  $*"        >&2; }
success() { echo -e "${GREEN}  ✓${RESET}  $*"      >&2; }
warn()    { echo -e "${YELLOW}  ⚠${RESET}  $*"     >&2; }
die()     { echo -e "${RED}  ✗  $*${RESET}"        >&2; exit 1; }
section() { echo -e "\n${BOLD}${MAGENTA}$*${RESET}" >&2; }

# ── GitHub raw base URL ───────────────────────────────────────────────────────
GITHUB_RAW="https://raw.githubusercontent.com/shunsui18/yazi/main"

# ── All files that must be fetched in remote mode ────────────────────────────
REMOTE_FILES=(
  flavors/yozakura-yoru.yazi/flavor.toml
  flavors/yozakura-yoru.yazi/theme.toml
  flavors/yozakura-yoru.yazi/tmtheme.xml
  flavors/yozakura-hiru.yazi/flavor.toml
  flavors/yozakura-hiru.yazi/theme.toml
  flavors/yozakura-hiru.yazi/tmtheme.xml
)

# ── Detect remote vs local execution ─────────────────────────────────────────
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REMOTE=0
if [[ "$SCRIPT_DIR" == /proc/* || "$SCRIPT_DIR" == /dev/fd* ]]; then
  REMOTE=1
  SCRIPT_DIR="$(mktemp -d)"
  trap 'rm -rf "$SCRIPT_DIR"' EXIT
  info "Remote install detected — fetching files from GitHub..." >&2
  echo "" >&2
  _total=${#REMOTE_FILES[@]}
  _idx=0
  for rel in "${REMOTE_FILES[@]}"; do
    _idx=$((_idx + 1))
    dest="${SCRIPT_DIR}/${rel}"
    mkdir -p "$(dirname "$dest")"
    printf "  ${DIM}[%2d/%d]${RESET}  ${CYAN}↓${RESET}  %s\n" "$_idx" "$_total" "$rel" >&2
    curl -fsSL --max-time 30 "${GITHUB_RAW}/${rel}" -o "$dest" \
      || die "Failed to download ${rel} from GitHub"
  done
  echo "" >&2
fi

# ── Build flavor list from available flavor directories ───────────────────────
mapfile -t FLAVORS < <(
  ls -d "${SCRIPT_DIR}"/flavors/yozakura-*.yazi 2>/dev/null \
    | sed 's/.*yozakura-//;s/\.yazi//' \
    | sort
)
[[ ${#FLAVORS[@]} -gt 0 ]] \
  || die "No flavors/yozakura-*.yazi directories found in ${SCRIPT_DIR}"

# ── Parse CLI flags ───────────────────────────────────────────────────────────
FLAVOR=""
DO_BACKUP=1

while [[ $# -gt 0 ]]; do
  case $1 in
    --theme)
      [[ -n "${2:-}" ]] || die "--theme requires a flavor argument (e.g. yoru, hiru)"
      FLAVOR="$2"; shift 2 ;;
    --theme=*)
      FLAVOR="${1#*=}"; shift ;;
    --no-backup)
      DO_BACKUP=0; shift ;;
    -h|--help)
      echo -e "Usage: bash install.sh [--theme <flavor>] [--no-backup]" >&2
      echo -e "       Available flavors : ${FLAVORS[*]}" >&2
      echo -e "       --no-backup       : skip backing up existing theme.toml" >&2
      echo -e "       Run without flags for interactive menu." >&2
      exit 0 ;;
    *)
      die "Unknown option: $1 — run with --help for usage" ;;
  esac
done

# ── Interactive menu (shown when no --theme flag was given) ───────────────────
if [[ -z "$FLAVOR" ]]; then
  declare -A FLAVOR_ICON=(  [yoru]="🌙" [hiru]="☀️" )
  declare -A FLAVOR_TAG=(   [yoru]="night" [hiru]="day" )
  declare -A FLAVOR_DESC=(
    [yoru]="deep navy blues, soft sakura accents"
    [hiru]="warm ivory canvas, gentle pastel tones"
  )
  declare -A FLAVOR_COLOR=( [yoru]="$LAVENDER" [hiru]="$PINK" )

  echo -e "" >&2
  echo -e "  ${PINK}╭────────────────────────────────────────╮${RESET}" >&2
  echo -e "  ${PINK}│${RESET}   ${BOLD}${PINK}🌸  夜桜  ·  yozakura  ·  yazi${RESET}       ${PINK}│${RESET}" >&2
  echo -e "  ${PINK}│${RESET}        ${DIM}choose a flavor to install${RESET}      ${PINK}│${RESET}" >&2
  echo -e "  ${PINK}╰────────────────────────────────────────╯${RESET}" >&2
  echo -e "" >&2

  for i in "${!FLAVORS[@]}"; do
    label="${FLAVORS[$i]}"
    icon="${FLAVOR_ICON[$label]:-  }"
    tag="${FLAVOR_TAG[$label]:-}"
    desc="${FLAVOR_DESC[$label]:-}"
    col="${FLAVOR_COLOR[$label]:-$RESET}"
    echo -e "    ${BOLD}${col}$((i+1))  ${icon}  ${label}${RESET}  ${DIM}(${tag})${RESET}" >&2
    echo -e "      ${DIM}${desc}${RESET}" >&2
    echo "" >&2
  done

  echo -ne "  ${BOLD}${PINK}❯${RESET} ${BOLD}Choice [1–${#FLAVORS[@]}]:${RESET} " >&2
  read -r choice </dev/tty
  echo "" >&2

  if [[ "$choice" =~ ^[0-9]+$ ]]; then
    idx=$((choice - 1))
    [[ $idx -ge 0 && $idx -lt ${#FLAVORS[@]} ]] \
      || die "Invalid choice: ${choice} — pick a number between 1 and ${#FLAVORS[@]}"
    FLAVOR="${FLAVORS[$idx]}"
  else
    FLAVOR="$(echo "$choice" | tr '[:upper:]' '[:lower:]' | xargs)"
  fi
fi

# ── Validate flavor ───────────────────────────────────────────────────────────
[[ -d "${SCRIPT_DIR}/flavors/yozakura-${FLAVOR}.yazi" ]] \
  || die "Flavor '${FLAVOR}' not found.\n       Available flavors: ${FLAVORS[*]}"
[[ -f "${SCRIPT_DIR}/flavors/yozakura-${FLAVOR}.yazi/theme.toml" ]] \
  || die "flavors/yozakura-${FLAVOR}.yazi/theme.toml missing — repo may be incomplete"

# ── Destination paths ─────────────────────────────────────────────────────────
YAZI_CFG_DIR="${HOME}/.config/yazi"
YAZI_FLAVORS_DIR="${YAZI_CFG_DIR}/flavors"

# ── Step 1 — Create directory tree ───────────────────────────────────────────
section "[ 1/4 ]  Preparing directories"
mkdir -p \
  "${YAZI_CFG_DIR}" \
  "${YAZI_FLAVORS_DIR}"
success "Config tree ready: ${DIM}${YAZI_CFG_DIR}${RESET}"

# ── Step 2 — Backup existing theme.toml ──────────────────────────────────────
section "[ 2/4 ]  Checking for existing theme.toml"
THEME_DEST="${YAZI_CFG_DIR}/theme.toml"

if [[ -e "$THEME_DEST" || -L "$THEME_DEST" ]]; then
  if [[ "$DO_BACKUP" -eq 1 ]]; then
    BACKUP_PATH="${YAZI_CFG_DIR}/theme.toml.bak.$(date +%Y%m%d_%H%M%S)"
    # Resolve symlink target for display, but copy the actual content
    if [[ -L "$THEME_DEST" ]]; then
      _real="$(readlink "$THEME_DEST")"
      cp --dereference "$THEME_DEST" "$BACKUP_PATH" 2>/dev/null \
        || cp "$THEME_DEST" "$BACKUP_PATH"
      success "Backed up symlink  ${DIM}(→ ${_real})${RESET}  →  ${DIM}${BACKUP_PATH}${RESET}"
    else
      cp "$THEME_DEST" "$BACKUP_PATH"
      success "Backed up theme.toml  →  ${DIM}${BACKUP_PATH}${RESET}"
    fi
  else
    warn "Skipping backup of existing theme.toml  ${DIM}(--no-backup)${RESET}"
  fi
else
  info "No existing theme.toml found — nothing to back up"
fi

# ── Step 3 — Install all flavor directories ───────────────────────────────────
section "[ 3/4 ]  Installing flavor directories"
for flavor_dir in "${SCRIPT_DIR}"/flavors/yozakura-*.yazi; do
  [[ -d "$flavor_dir" ]] || continue
  flavor_name="$(basename "$flavor_dir")"
  dest_dir="${YAZI_FLAVORS_DIR}/${flavor_name}"
  mkdir -p "$dest_dir"
  for f in flavor.toml theme.toml tmtheme.xml; do
    src="${flavor_dir}/${f}"
    [[ -f "$src" ]] || { warn "Missing ${flavor_name}/${f} — skipping"; continue; }
    cp "$src" "${dest_dir}/${f}"
    success "Installed  ${DIM}flavors/${flavor_name}/${f}${RESET}"
  done
done

# ── Step 4 — Symlink active theme ─────────────────────────────────────────────
section "[ 4/4 ]  Linking active theme  →  ${FLAVOR}"

# Remove stale symlink or file before re-linking
[[ -L "$THEME_DEST" || -f "$THEME_DEST" ]] && rm -f "$THEME_DEST"

# Symlink theme.toml → flavors/yozakura-<flavor>.yazi/theme.toml
ln -s "${YAZI_FLAVORS_DIR}/yozakura-${FLAVOR}.yazi/theme.toml" "${THEME_DEST}"

success "Linked  ${BOLD}theme.toml${RESET}${GREEN}  →  ${DIM}flavors/yozakura-${FLAVOR}.yazi/theme.toml${RESET}"

# ── Done ──────────────────────────────────────────────────────────────────────
echo "" >&2
echo -e "${BOLD}${PINK}  ✦  yozakura / ${FLAVOR} installed successfully!${RESET}" >&2
echo -e "${DIM}      Config  : ${THEME_DEST}" >&2
echo -e "      Flavor  : ${YAZI_FLAVORS_DIR}/yozakura-${FLAVOR}.yazi/theme.toml" >&2
if [[ "$DO_BACKUP" -eq 1 && -n "${BACKUP_PATH:-}" ]]; then
  echo -e "      Backup  : ${BACKUP_PATH}${RESET}" >&2
fi
echo "" >&2