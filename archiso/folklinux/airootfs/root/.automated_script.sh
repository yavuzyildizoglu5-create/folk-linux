#!/usr/bin/env bash
# Folk Linux — ISO açılışında çalışan otomatik kurulum scripti
# Archiso: /root/.automated_script.sh — live kullanıcı oturumu açılmadan önce çalışır.
set -euo pipefail

# Dil ve klavye
sed -i 's/^#\(tr_TR.UTF-8 UTF-8\)/\1/' /etc/locale.gen 2>/dev/null || true
locale-gen >/dev/null 2>&1 || true

# Ağ servisini etkinleştir
systemctl enable --now NetworkManager >/dev/null 2>&1 || true

# SDDM'i etkinleştir
systemctl enable sddm >/dev/null 2>&1 || true

# Plymouth temasını ayarla (varsa)
if [[ -d /usr/share/plymouth/themes/folklinux ]]; then
    plymouth-set-default-theme -R folklinux >/dev/null 2>&1 || true
fi

# Masaüstü kısayollarını folk kullanıcısına kopyala
if [[ -d /etc/skel/Desktop ]]; then
    cp -r /etc/skel/Desktop/. /home/folk/Desktop/ 2>/dev/null || true
    chown -R folk:folk /home/folk/Desktop 2>/dev/null || true
fi

# Calamares'i masaüstüne sabitle
if [[ -f /usr/share/applications/calamares.desktop ]]; then
    cp /usr/share/applications/calamares.desktop /home/folk/Desktop/ 2>/dev/null || true
    chmod +x /home/folk/Desktop/calamares.desktop 2>/dev/null || true
    chown folk:folk /home/folk/Desktop/calamares.desktop 2>/dev/null || true
fi

exit 0
