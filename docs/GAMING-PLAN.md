# Folk Linux — Oyun Katmanı Planı (Faz 2)

> Bu belge şimdilik taslak. Faz 1 (çalışan ISO) tamamlandığında uygulamaya geçilecek.

## Hedef

Arch tabanlı, KDE Plasma'lı, **kutudan çıktığı gibi oyun oynatabilen** bir sistem.
Kurulum sonrası ek ayar yapmadan Steam açılır, Proton çalışır, GPU doğru kullanılır.

---

## Paket Grupları

### Zorunlu (her kurulumda)
| Paket | Açıklama |
|---|---|
| `steam` | Valve oyun platformu |
| `lib32-gcc-libs` | 32-bit oyunlar için |
| `mesa` + `lib32-mesa` | Açık kaynak OpenGL/Vulkan |
| `vulkan-icd-loader` + `lib32-vulkan-icd-loader` | Vulkan katmanı |
| `gamemode` + `lib32-gamemode` | Oyun sırasında CPU/GPU optimizasyonu |
| `mangohud` + `lib32-mangohud` | FPS / sıcaklık göstergesi |

### Launcher'lar
| Paket | Açıklama |
|---|---|
| `lutris` | GOG, Epic, Battle.net oyunları |
| `heroic-games-launcher-bin` (AUR) | Epic + GOG |
| `bottles` | Wine prefix yöneticisi |
| `wine` + `wine-gecko` + `wine-mono` | Windows uygulamaları |

### Sürücüye özel
**NVIDIA**
- `nvidia-dkms` (güncel çekirdekle uyumlu)
- `lib32-nvidia-utils`
- `nvidia-settings`
- Opsiyonel: `optimus-manager` (hybrid GPU)

**AMD**
- `xf86-video-amdgpu` (zaten Faz 1'de)
- `vulkan-radeon` + `lib32-vulkan-radeon` (RADV)
- `radeontop`

**Intel**
- `intel-media-driver` (VA-API)
- `libvulkan-intel` + `lib32-libvulkan-intel`

---

## Çekirdek Stratejisi

Varsayılan `linux` paketi yerine `linux-zen` önerilecek:
- Daha düşük gecikme (low-latency)
- Oyun ve medya için optimize edilmiş scheduler
- Arch resmi deposunda mevcut, ek risk yok

İleri seviye kullanıcılar için `linux-tkg` (AUR) opsiyonu dokümante edilecek.

---

## Sistem Ayarları (sysctl)

`/etc/sysctl.d/99-folk-gaming.conf` dosyasıyla:

```conf
# Daha az swap kullanımı (oyun sırasında takılma önleme)
vm.swappiness = 10

# Disk yazma optimize etme
vm.dirty_ratio = 60
vm.dirty_background_ratio = 2

# Ağ buffer'ları (online oyun)
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
```

> Bu ayarlar Faz 1'de eklenmeyecek — önce temel sistemin stabil olduğundan emin olacağız.

---

## Gamemode Entegrasyonu

`/etc/gamemode.ini` ile:
- CPU governor → `performance`
- GPU overclock profili (desteklenen kartlarda)
- Kompositor etkilerini azaltma
- `mangohud` otomatik başlatma

Kullanım: `gamemoderun %command%` (Steam launch option)

---

## Wayland + Gamescope

- KDE Plasma Wayland oturumu varsayılan olacak
- `gamescope` ile oyunları ayrı oturumda çalıştırma (VSYNC, FSR desteği)
- X11 oyunları için XWayland tam yapılandırılacak

---

## Açık Sorular

1. Flatpak Steam mi, native pacman Steam mi? → İkisi de sunulacak, varsayılan native.
2. `linux-zen` varsayılan mı, opsiyon mu? → Faz 1 testlerinden sonra karar verilecek.
3. NVIDIA kurulumu ISO'ya dahil mi? → Hayır, kurulum sonrası `folk-install gaming` ile.

---

*Bkz: [`ROADMAP.md`](ROADMAP.md) — genel proje planı*
