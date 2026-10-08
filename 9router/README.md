# Panduan Konfigurasi 9Router

9Router bertindak sebagai AI Gateway lokal yang berjalan di port `20128` (`http://127.0.0.1:20128`).
Hermes dikonfigurasi untuk berbicara ke port ini.

## 1. Menjalankan 9Router
Setelah 9Router terpasang (via npm atau binary):
```bash
9router start
```
Buka dashboard di browser (biasanya `http://localhost:20128`).

## 2. Model Alias Mapping (Wajib Sama)
Hermes membutuhkan 2 model alias agar alur otomatis berjalan:

1. **`hermes-default`**:
   - Model untuk Meta-Orchestrator, analisis, non-coding reasoning.
   - Contoh mapping provider: Claude 3.5 Sonnet / GPT-4o / Qwen 2.5 72B.

2. **`hermes-code`**:
   - Model untuk Sub-Agent implementasi teknis & coding.
   - Contoh mapping provider: DeepSeek-Coder / Claude 3.5 Sonnet / Qwen-2.5-Coder-32B.

Buat alias `hermes-default` dan `hermes-code` di dashboard 9Router Anda dan arahkan ke model provider pilihan Anda yang aktif.
