#!/usr/bin/env bash
# Archiso profil tanımı — Folk Linux
# Kaynak: https://gitlab.archlinux.org/archlinux/archiso/-/blob/master/config/profiledef.sh

iso_name="folklinux"
iso_label="FOLKLINUX_$(date +%Y%m)"
iso_publisher="Folk Linux <https://github.com/folk-linux>"
iso_application="Folk Linux Live/Install Media"
iso_version="$(date +%Y.%m.%d)"
install_dir="folk"
# Güncel archiso boot modları (efitools kaldırıldı, systemd-boot kullanılıyor)
bootmodes=('bios.syslinux' 'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"

# Paket imzalarını doğrula
pacman_conf="pacman.conf"

# Sıkıştırma: zstd -19 (xz'den hızlı ve daha iyi oran) — ISO boyutunu ~%25 küçültür
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '19' '-b' '1M')

# Bootstrap paketleri (ISO'yu oluştururken kullanılır)
bootstrap_packages=(
    base
)

# ISO dosya izinleri: dosya:mod:sahip:grup
file_permissions=(
    ["/etc/shadow"]="0:0:640"
    ["/etc/gshadow"]="0:0:640"
    ["/etc/shadow-"]="0:0:640"
    ["/etc/gshadow-"]="0:0:640"
    ["/root"]="0:0:750"
    ["/root/.automated_script.sh"]="0:0:755"
    ["/usr/local/bin/folk-install"]="0:0:755"
)
