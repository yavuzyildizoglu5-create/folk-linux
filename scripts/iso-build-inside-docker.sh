#!/usr/bin/env bash
# Folk Linux — Docker container İÇİNDE çalışan ISO derleme scripti
# Bu dosya .github/workflows/build.yml tarafından çağrılır.
# Amacı: YAML içine gömülen karmaşık quote'ları ortadan kaldırmak.
set -euo pipefail

cd /work

log() { echo "[FOLK-BUILD] $*"; }

log "Arch paketleri hazırlanıyor..."
pacman-key --init
pacman -Syu --noconfirm --needed archiso dosfstools mtools syslinux

PROFILE_DIR=archiso/folklinux

log "Profil doğrulanıyor..."
bash -n "$PROFILE_DIR/profiledef.sh" || { echo "HATA: profiledef.sh sözdizimi bozuk!"; exit 1; }
log "profiledef.sh sözdizimi geçerli"
grep -E "^(iso_name|install_dir|bootmodes)=" "$PROFILE_DIR/profiledef.sh"
log "Boot dosyaları:"
find "$PROFILE_DIR/syslinux" "$PROFILE_DIR/efiboot" -type f

log "ISO derleniyor..."
cd archiso
mkdir -p ../output ../work
mkarchiso -v -w ../work -o ../output folklinux

log "ISO tamamlandı."
ls -lh ../output/

# SHA512 doğrulama dosyasını container içinde (root olarak) oluştur.
# Dışarıda (runner kullanıcısı) yazmaya çalışırsak Permission denied alınır.
ISO_FILE=$(find ../output -maxdepth 1 -name '*.iso' -type f | head -n1)
if [[ -z "$ISO_FILE" ]]; then
    echo "HATA: ISO dosyası bulunamadı!" && exit 1
fi
log "SHA512 oluşturuluyor: $(basename "$ISO_FILE")"
(cd ../output && sha512sum "$(basename "$ISO_FILE")" > "$(basename "$ISO_FILE").sha512")
chmod 644 ../output/*

log "✓ Çıktılar hazır:"
ls -lh ../output/
cat "../output/$(basename "$ISO_FILE").sha512"
