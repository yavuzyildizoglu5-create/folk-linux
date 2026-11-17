#!/usr/bin/env bash
# Folk Linux — Profil doğrulayıcı
# ISO derlemeden önce yaygın hataları yakalar. Windows/Git Bash'te de çalışır.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE="$SCRIPT_DIR/archiso/folklinux"
ERRORS=0

check() {
    local desc="$1"; shift
    if "$@" >/dev/null 2>&1; then
        echo "  [OK]   $desc"
    else
        echo "  [HATA] $desc"
        ERRORS=$((ERRORS + 1))
    fi
}

echo "Folk Linux profil kontrolü..."
echo "────────────────────────────"

check "profiledef.sh mevcut"        test -f "$PROFILE/profiledef.sh"
check "packages.x86_64 mevcut"      test -f "$PROFILE/packages.x86_64"
check "pacman.conf mevcut"          test -f "$PROFILE/pacman.conf"
check "airootfs/etc mevcut"         test -d "$PROFILE/airootfs/etc"
check "hostname ayarlı"             test -s "$PROFILE/airootfs/etc/hostname"
check "locale.gen ayarlı"           test -s "$PROFILE/airootfs/etc/locale.gen"
check "SDDM yapılandırması var"     test -f "$PROFILE/airootfs/etc/sddm.conf.d/10-folklinux.conf"
check "Calamares settings var"      test -f "$PROFILE/airootfs/etc/calamares/settings.conf"
check "KDE skel dizini var"         test -d "$PROFILE/airootfs/etc/skel/.config"
check "Duvar kağıdı var"            test -f "$PROFILE/airootfs/usr/share/backgrounds/folklinux/folklinux-default.svg"
check "Logo var"                    test -f "$PROFILE/airootfs/usr/share/icons/folklinux/folklinux-logo.svg"
check "Kurulum scripti var"         test -f "$PROFILE/airootfs/root/.automated_script.sh"
check "GitHub workflow var"         test -f "$SCRIPT_DIR/.github/workflows/build.yml"
check "build.sh mevcut"             test -f "$SCRIPT_DIR/build.sh"

echo "────────────────────────────"
if [[ $ERRORS -eq 0 ]]; then
    echo "✓ Tüm kontroller geçti. Profil derlemeye hazır."
    exit 0
else
    echo "✗ $ERRORS kontrol başarısız. Lütfen düzelt."
    exit 1
fi
