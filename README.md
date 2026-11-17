# Folk Linux

> Arch tabanlı, KDE Plasma masaüstüyle gelen, oyun odaklı GNU/Linux dağıtımı.

**Durum:** Erken geliştirme — temel sistem katmanı kuruluyor.

---

## Proje Özeti

| Özellik | Değer |
|---|---|
| Taban | GNU/Linux |
| Aile | Arch Linux (rolling release) |
| Masaüstü | KDE Plasma (güncel) |
| Init | systemd |
| Paket yöneticisi | pacman |
| Hedef mimari | x86_64 |
| Odak | Oyun (Faz 2'de Steam, Proton, sürücü Optimization) |
| ISO aracı | archiso (resmi Arch ISO üreticisi) |

---

## Hızlı Başlangıç

### Bulutta derle (Windows / macOS / Linux fark etmez)

Bu depoya `push` yaptığında GitHub Actions otomatik olarak ISO'yu üretir.
`Actions` sekmesinden ilgili run'a girip **Artifacts** altından ISO'yu indir.

### Yerel derle (Arch Linux gerektirir)

```bash
git clone <repo-url> folk-linux
cd folk-linux
sudo ./build.sh
# Çıktı: output/folk-linux-YYYY.MM.DD-x86_64.iso
```

Detaylar: [`docs/BUILDING.md`](docs/BUILDING.md)

---

## Dizin Yapısı

```
Folk Linux/
├── archiso/folklinux/     # Archiso profili — ISO'nun tarifi
│   ├── profiledef.sh      # ISO meta verisi (ad, sürüm, dosya adı)
│   ├── packages.x86_64    # Kurulacak paketlerin listesi
│   ├── pacman.conf        # Paket kaynakları
│   └── airootfs/          # ISO içindeki dosya sistemi
│       ├── etc/           # Sistem yapılandırması
│       ├── root/          # Kurulum sonrası scriptler
│       └── usr/share/     # Tema, duvar kağıdı, logo
├── branding/              # SVG kaynak dosyaları (logo, duvar kağıdı)
├── scripts/               # Yardımcı scriptler
├── .github/workflows/     # Otomatik ISO derleme hattı
└── docs/                  # Dokümantasyon ve yol haritası
```

---

## Yol Haritası

- [x] **Faz 0** — Proje iskeleti ve build hattı
- [ ] **Faz 1** — Çekirdek sistem + KDE Plasma + Calamares kurulumcu → *ilk boot edilebilir ISO*
- [ ] **Faz 2** — Oyun katmanı: Steam, Proton, Mesa, nvidia/amd sürücüleri, gamemode
- [ ] **Faz 3** — Folk Linux markası: özel tema, ikonlar, ses teması, Plymouth
- [ ] **Faz 4** — Kararlılık, güncelleme aracı, ToS/uyumluluk testleri

Ayrıntılar: [`docs/ROADMAP.md`](docs/ROADMAP.md)

---

## Lisans

Folk Linux'in kendisi **GPL-3.0** altındadır. İçerdiği yazılımların (Arch Linux,
KDE Plasma, Linux çekirdeği vb.) kendi lisansları geçerlidir. Detay: [`LICENSE`](LICENSE)
