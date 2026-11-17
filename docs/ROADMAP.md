# Folk Linux — Yol Haritası

Bu belge projeyi aşamalara böler. Her faz, bir öncekinin üzerine inşa edilir.

---

## Faz 0 — Temel altyapı ✓ (tamamlandı)

- [x] Repo yapısı ve lisans
- [x] Archiso profili (profiledef, packages, pacman.conf)
- [x] Çekirdek sistem dosyaları (hostname, locale, klavye, timezone, mkinitcpio)
- [x] KDE Plasma + SDDM yapılandırması
- [x] Calamares kurulumcu iskeleti
- [x] Marka varlıkları (logo, duvar kağıdı SVG)
- [x] GitHub Actions build hattı
- [x] Yerel build scripti ve doğrulama aracı
- [x] Dokümantasyon

**Çıktı:** Derlemeye hazır bir proje. Henüz ISO üretilmedi.

---

## Faz 1 — İlk boot edilebilir ISO (şu anki odak)

**Amaç:** Açılıp masaüstüne düşen, diske kurulabilen bir ISO.

- [ ] GitHub Actions ile ilk ISO'yu üret ve indir
- [ ] QEMU / sanal makinede açılışı test et
- [ ] Calamares ile kurulumu test et (disk bölümleme → kullanıcı → reboot)
- [ ] Kurulu sistemde ağ, ses, ekran kartı sürücülerini doğrula
- [ ] Paket listesini sadeleştir / eksikleri ekle
- [ ] Plymouth PNG varlıklarını üret (SVG → PNG dönüşümü)
- [ ] ISO boyutunu optimize et (hedef: < 3.5 GB)

**Kabul kriteri:** ISO açılır → Plasma masaüstü gelir → Calamares sorunsuz kurulum yapar → reboot sonrası sistem çalışır.

---

## Faz 2 — Oyun odaklı katman

**Amaç:** Folk Linux'u gerçekten oyun makinesi yapmak.

### 2.1 Oyun çalışma zamanı
- [ ] Steam (native + flatpak seçeneği)
- [ ] Proton / Proton-GE kurulum aracı
- [ ] Lutris, Heroic Games Launcher, Bottles
- [ ] Wine + wine-gecko + wine-mono
- [ ] Gamemode + MangoHud (FPS izleme)
- [ ] vkBasalt (Vulkan post-processing)

### 2.2 Sürücü optimizasyonu
- [ ] NVIDIA: `nvidia-dkms`, `lib32-nvidia-utils`, optimus-manager prime
- [ ] AMD: `mesa` Vulkan (RADV), `radeontop`
- [ ] Intel: `intel-media-driver`, VA-API
- [ ] `lib32` katmanının tamamlanması (32-bit oyunlar için)

### 2.3 Çekirdek optimizasyonu
- [ ] Zen kernel veya `-zen` cpugovernor seçeneği
- [ ] `linux-tkg` / `linux-zen` paketleri
- [ ] Low-latency kernel alternatifi
- [ ] `sysctl` oyun profili (vm.swappiness, scheduler)

### 2.4 Oyun deneyimi
- [ ] Oyun modu: Composite'i kapat, CPU governor'ı performance'a al
- [ ] Discord, OBS Studio
- [ ] Oyun odaklı KDE tema (koyu, düşük dikkat dağıtma)
- [ ] Controller desteği (steam-devices, xboxdrv, ds4drv)

---

## Faz 3 — Kimlik ve cilalama

- [ ] Folk Linux özel Breeze tema varyantı
- [ ] Papirus ikon seti üzerine özelfolk ikonları
- [ ] Ses teması (login/logout/shutdown sesleri)
- [ ] Plymouth tam SVG→PNG tema seti
- [ ] SDDM özel giriş ekranı arka planı
- [ ] `folk-install` aracını tam fonksiyonel hale getirme
- [ ] Aylık güncelleme (rolling release) doğrulama hattı

---

## Faz 4 — Dağıtım olgunluğu

- [ ] Kararlı sürüm etiketleme (v1.0, v2.0...)
- [ ] Günlük/haftalık otomatik ISO (nightly build)
- [ ] Torrent + direkt indirme linkleri
- [ ] Discord / forum topluluğu
- [ ] Hata raporlama şablonları
- [ ] Donanım uyumluluk listesi (HCL)

---

## Kararlar ve Notlar

| Karar | Sebep |
|---|---|
| Arch tabanı seçildi | Rolling release, güncel sürücüler, AUR erişimi — oyun için ideal |
| KDE Plasma | Hafif, özelleştirilebilir, Wayland desteği, oyun modu kolay |
| Archiso kullanımı | Resmi araç, bakımı kolay, topluluk desteği güçlü |
| GitHub Actions | Windows'tan yönetim için en pratik yol, ücretsiz Linux runner |
| Faz 2'de gnome değil KDE | Wayland + Gamescope uyumu, düşük kaynak tüketimi |

---

## Şu An Ne Yapmalıyız?

1. Depoyu GitHub'a yükle ve Actions ile **ilk ISO'yu üret**.
2. ISO'yu indir, sanal makinede aç, hataları not et.
3. Faz 1 kapanış kontrol listesini işaretle.
4. Sonra Faz 2'ye (oyun katmanı) geç.

İlk ISO'yu aldıktan sonra birlikte test edip düzeltelim.
