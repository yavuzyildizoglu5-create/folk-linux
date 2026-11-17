#!/usr/bin/env bash
# Folk Linux — Yerel test ortamı hazırlayıcı
# Arch Linux üzerinde çalışır: gerekli paketleri kurar.
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; NC='\033[0m'
log() { echo -e "${GREEN}[FOLK]${NC} $*"; }
err() { echo -e "${RED}[HATA]${NC} $*" >&2; exit 1; }

[[ $EUID -ne 0 ]] && err "Root olarak çalıştır (sudo ./scripts/setup-local.sh)."
grep -q 'Arch Linux' /etc/os-release 2>/dev/null || err "Yalnızca Arch Linux desteklenir."

log "Gerekli paketler kuruluyor..."
pacman -Syu --needed --noconfirm \
    archiso git rsync curl wget dosfstools syslinux grub efibootmgr \
    squashfs-tools mtools || err "Paket kurulumu başarısız."

log "✓ Build ortamı hazır. Şimdi: sudo ./build.sh"
