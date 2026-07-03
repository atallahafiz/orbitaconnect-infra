# OrbitaConnect Infrastructure

![Docker](https://img.shields.io/badge/Docker-Docker%20Compose-2496ED?style=flat-square&logo=docker&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-005571?style=flat-square&logo=fastapi&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-4169E1?style=flat-square&logo=postgresql&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=flat-square&logo=nginx&logoColor=white)

OrbitaConnect adalah platform infrastruktur *hybrid* (IaaS/PaaS) berbasis kontainer yang mengintegrasikan **FastAPI** dan **PostgreSQL** untuk simulasi ekosistem *Online Travel Agency* (OTA). Proyek ini berfokus pada otomatisasi *deployment*, isolasi jaringan, dan pengamanan data.

---

## ✨ Fitur Utama

* ⚡ **One-Command Deployment:** Manajemen *lifecycle* kontainer sepenuhnya diotomatisasi menggunakan perintah `make`.
* 🛡️ **Network Isolation:** Database PostgreSQL terisolasi penuh di dalam Docker `private_net`, hanya bisa diakses oleh backend dan **SSH Bastion** (Key-based auth via Ed25519).
* 🔒 **Least Privilege Access:** Kontainer aplikasi berjalan dengan user non-root (`appuser`) untuk meminimalisir celah keamanan.
* 💾 **Disaster Recovery:** Tersedia skrip otomatisasi untuk proses *backup* dan *restore* database secara instan.

---

## 🚀 Memulai (Quick Start)

### Prasyarat
* Docker Desktop (Terintegrasi dengan WSL2 Ubuntu)
* `make` utilitas terinstal di Linux/WSL

### Langkah Instalasi

1. **Clone Repositori & Masuk ke Folder**
   ```bash
   git clone [https://github.com/username/orbitaconnect-infra.git](https://github.com/username/orbitaconnect-infra.git)
   cd orbitaconnect-infra
   ```

2. **Setup Environment Variables**
   ```bash
   cp .env.example .env
   ```

3. **Jalankan Seluruh Environment**
   ```bash
   make up
   ```

---

## 🧪 Pengujian API

Setelah semua kontainer berjalan dan berstatus `Healthy`, Anda bisa menguji endpoint utama via Terminal:

* **Cek Koneksi Sistem & DB:**
  ```bash
  curl http://localhost:8000/health
  ```

* **Simulasi Ingest Data (Supplier):**
  ```bash
  curl -X POST http://localhost:8000/ingest \
    -H "Content-Type: application/json" \
    -d '{"supplier_id":"SUP-001","external_hotel_id":"HTL-01","name":"Grand Hotel","rates":[],"availability":[]}'
  ```

🔗 **Dokumentasi UI:** Akses [http://localhost:8000/docs](http://localhost:8000/docs) untuk mencoba Swagger UI interaktif.

---

## 📂 Struktur Repositori

```text
├── docker-compose.yml   # Orkestrasi container (Infra, API, Proxy)
├── Makefile             # CLI automation (make up, make down, make backup, dll)
├── ota-mini-api/        # Source code aplikasi FastAPI
├── postgres/            # Skema inisialisasi awal database
├── scripts/             # Shell scripts untuk backup & provisioning
└── ssh-keys/            # Kredensial keamanan untuk SSH Bastion
```
