#!/usr/bin/env bash
# Folk Linux — Ana ISO derleme scripti
# Gereksinimler: Arch Linux + archiso + sudo
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE="folklinux"
PROFILE_DIR="$SCRIPT_DIR/archiso/$PROFILE"
OUTPUT_DIR="$SCRIPT_DIR/output"
DATE_STAMP="$(date +%Y.%m.%d)"
ISO_NAME="FolkLinux-${DATE_STAMP}-x86_64.iso"

# Renkler
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()  { echo -e "${GREEN}[FOLK]${NC} $*"; }
warn() { echo -e "${YELLOW}[UYARI]${NC} $*"; }
err()  { echo -e "${RED}[HATA]${NC} $*" >&2; exit 1; }

check_env() {
    [[ $EUID -ne 0 ]] && err "Bu script root olarak çalıştırılmalıdır (sudo ./build.sh)."
    grep -q 'Arch Linux' /etc/os-release 2>/dev/null || \
        err "Bu script yalnızca Arch Linux üzerinde çalışır."
    command -v mkarchiso >/dev/null 2>&1 || \
        err "archiso kurulu değil. 'sudo pacman -S archiso' ile kurun."
    [[ -f "$PROFILE_DIR/profiledef.sh" ]] || err "Profil bulunamadı: $PROFILE_DIR"
    log "Ortam kontrolü tamam."
}

clean() {
    log "Önceki çıktılar temizleniyor..."
    rm -rf "$OUTPUT_DIR"
    mkdir -p "$OUTPUT_DIR"
}

build() {
    log "ISO derleniyor: $ISO_NAME"
    cd "$SCRIPT_DIR/archiso"
    mkarchiso -v -w "$SCRIPT_DIR/work" -o "$OUTPUT_DIR" "$PROFILE" 2>&1 | tee "$OUTPUT_DIR/build.log"
    log "ISO hazır: $OUTPUT_DIR/$ISO_NAME"
}

checksum() {
    log "SHA512 oluşturuluyor..."
    cd "$OUTPUT_DIR"
    sha512sum "$ISO_NAME" > "$ISO_NAME.sha512"
    log "Doğrulama dosyası: $ISO_NAME.sha512"
}

main() {
    check_env
    clean
    build
    checksum
    log "✓ Folk Linux ISO başarıyla üretildi."
    echo "  Çıktı: $OUTPUT_DIR/$ISO_NAME"
}

main "$@"
