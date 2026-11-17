# Folk Linux — Derleme Kılavuzu

## Genel Bakış

Folk Linux ISO'su **archiso** (Arch Linux'ın resmi ISO aracı) ile üretilir.
İki yolun var: **GitHub Actions** (önerilen, Windows'tan çalışır) veya **yerel Arch**.

---

## Yol 1: GitHub Actions (Windows / macOS / Linux)

En kolay ve en güvenilir yöntem. Hiçbir şey kurmana gerek yok.

1. Depoyu GitHub'a yükle:
   ```bash
   git init
   git add .
   git commit -m "Folk Linux ilk kurulum"
   git remote add origin https://github.com/KULLANICI/folk-linux.git
   git push -u origin main
   ```
2. GitHub'da **Actions** sekmesine git.
3. Soldan **Folk Linux ISO Build** iş akışını seç.
4. **Run workflow** butonuna bas (veya her `push` otomatik başlar).
5. İş bitince run sayfasına gir → **Artifacts** → `folk-linux-iso-XXXXX` → İndir.

> İlk derleme paket indirmeleri nedeniyle 20-40 dakika sürebilir.
> Sonraki derlemeler daha hızlıdır.

**Avantajı:** Senin makinen kirlenmez, her seferinde temiz Arch ortamında derlenir.

---

## Yol 2: Yerel Derleme (Arch Linux gerektirir)

Bir Arch Linux kurulumu veya Arch sanal makinesi gerekir.

```bash
# 1. Gerekli araçları kur
sudo ./scripts/setup-local.sh

# 2. Profili doğrula
bash scripts/validate.sh

# 3. ISO'yu derle
sudo ./build.sh

# 4. Çıktı
ls -lh output/
# folk-linux-2026.11.18-x86_64.iso
# folk-linux-2026.11.18-x86_64.iso.sha512
```

### Gereksinimler
- Arch Linux (güncel)
- `archiso`, `git`, `rsync`, `squashfs-tools` (setup script kurar)
- En az 8 GB RAM, 20 GB boş disk
- Root yetkisi (sudo)

---

## ISO'yu Test Etme

### Sanal makine (QEMU)
```bash
qemu-system-x86_64 \
  -m 4096 -smp 4 \
  -cdrom output/folk-linux-*.iso \
  -boot d
```

### USB'ye yazma (Linux)
```bash
sudo dd if=output/folk-linux-*.iso of=/dev/sdX bs=4M status=progress
```

### Windows'ta USB'ye yazma
Rufus kullan: https://rufus.ie → ISO'yu seç → GPT/UEFI modu → Başlat.

---

## Profili Özelleştirme

| Ne değiştirmek istersin | Dosya |
|---|---|
| ISO adı / sürümü | `archiso/folklinux/profiledef.sh` |
| Kurulacak paketler | `archiso/folklinux/packages.x86_64` |
| Paket depoları | `archiso/folklinux/pacman.conf` |
| Sistem ayarları (hostname, locale, klavye) | `archiso/folklinux/airootfs/etc/` |
| KDE / SDDM teması | `archiso/folklinux/airootfs/etc/sddm.conf.d/` |
| Yeni kullanıcı varsayılanları | `archiso/folklinux/airootfs/etc/skel/` |
| Kurulumcu davranışı | `archiso/folklinux/airootfs/etc/calamares/` |
| Logo / duvar kağıdı | `branding/` → sonra `airootfs/usr/share/` içine kopyala |

> Değişiklikten sonra mutlaka `bash scripts/validate.sh` çalıştır.

---

## Sorun Giderme

**`mkarchiso: command not found`** → `sudo pacman -S archiso`

**İmza doğrulama hatası** → `sudo pacman-key --init && sudo pacman-key --populate archlinux`

**Disk alanı yetersiz** → `work/` dizinini temizle: `sudo rm -rf work output`

**GitHub Actions başarısız** → Run loglarını oku; genelde paket adı yazım hatasıdır.

**ISO açılmıyor** → `sha512sum -c *.sha512` ile dosya bütünlüğünü doğrula.
