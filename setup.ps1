<#
.SYNOPSIS
    Instalasi & setup otomatis Hermes + 9Router + Obsidian Ecosystem di Windows.
#>

$ErrorActionPreference = "Stop"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "   HERMES + 9ROUTER + OBSIDIAN ECOSYSTEM SETUP (WINDOWS)  " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$CurrentDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$WorkspaceDir = Join-Path $CurrentDir "workspace"
$VaultDir = Join-Path $CurrentDir "vault"
$HermesDir = "$env:LOCALAPPDATA\hermes"

# 1. Pastikan folder lokal ada
if (!(Test-Path $WorkspaceDir)) { New-Item -ItemType Directory -Path $WorkspaceDir | Out-Null }
if (!(Test-Path $VaultDir)) {
    Write-Host "[1/5] Menginisialisasi Obsidian Vault..." -ForegroundColor Green
    Copy-Item -Recurse -Path "$CurrentDir\vault-template\*" -Destination $VaultDir
}

# 2. Cek Dependencies
Write-Host "[2/5] Memeriksa runtime (Node.js & Python)..." -ForegroundColor Green
if (!(Get-Command "node" -ErrorAction SilentlyContinue)) {
    Write-Warning "Node.js belum terdeteksi. Silakan pasang Node.js LTS terlebih dahulu."
}
if (!(Get-Command "python" -ErrorAction SilentlyContinue)) {
    Write-Warning "Python belum terdeteksi. Silakan pasang Python 3.10+ terlebih dahulu."
}

# 3. Setup Hermes AppData Directory
Write-Host "[3/5] Menyiapkan direktori Hermes ($HermesDir)..." -ForegroundColor Green
if (!(Test-Path $HermesDir)) { New-Item -ItemType Directory -Path $HermesDir | Out-Null }
if (!(Test-Path "$HermesDir\plugins")) { New-Item -ItemType Directory -Path "$HermesDir\plugins" | Out-Null }
if (!(Test-Path "$HermesDir\memories")) { New-Item -ItemType Directory -Path "$HermesDir\memories" | Out-Null }

# 4. Copy Plugin Agency Agents
Write-Host "[4/5] Memasang Agency Agents Router..." -ForegroundColor Green
Copy-Item -Recurse -Force -Path "$CurrentDir\hermes\plugins\agency-agents-router" -Destination "$HermesDir\plugins\"

# 5. Pasang Konfigurasi, SOUL, dan Memory dengan Path Terkunci Dinamis
Write-Host "[5/5] Mengonfigurasi SOUL.md dan Sandbox Boundaries..." -ForegroundColor Green

# Normalisasi path untuk SOUL.md (gunakan backslash & forward slash yang aman)
$EscapedWorkspace = $WorkspaceDir.Replace('\', '/')
$EscapedVault = $VaultDir.Replace('\', '/')

# SOUL.md
$SoulContent = Get-Content -Raw -Path "$CurrentDir\hermes\SOUL.template.md"
$SoulContent = $SoulContent.Replace("{{WORKSPACE_DIR}}", $EscapedWorkspace)
$SoulContent = $SoulContent.Replace("{{VAULT_DIR}}", $EscapedVault)
Set-Content -Path "$HermesDir\SOUL.md" -Value $SoulContent -Encoding UTF8

# config.yaml (jika belum ada config kustom)
if (!(Test-Path "$HermesDir\config.yaml")) {
    Copy-Item -Path "$CurrentDir\hermes\config.template.yaml" -Destination "$HermesDir\config.yaml"
} else {
    Write-Host "  -> config.yaml sudah ada di $HermesDir. Template disalin sebagai config.dist.yaml." -ForegroundColor Yellow
    Copy-Item -Path "$CurrentDir\hermes\config.template.yaml" -Destination "$HermesDir\config.dist.yaml"
}

# MEMORY.md & USER.md
$MemoryContent = Get-Content -Raw -Path "$CurrentDir\hermes\memories\MEMORY.template.md"
$MemoryContent = $MemoryContent.Replace("{{WORKSPACE_DIR}}", $EscapedWorkspace)
$MemoryContent = $MemoryContent.Replace("{{VAULT_DIR}}", $EscapedVault)
Set-Content -Path "$HermesDir\memories\MEMORY.md" -Value $MemoryContent -Encoding UTF8

$UserContent = Get-Content -Raw -Path "$CurrentDir\hermes\memories\USER.template.md"
$UserContent = $UserContent.Replace("{{VAULT_DIR}}", $EscapedVault)
Set-Content -Path "$HermesDir\memories\USER.md" -Value $UserContent -Encoding UTF8

Write-Host "`n==========================================================" -ForegroundColor Green
Write-Host " Setup Selesai!" -ForegroundColor Green
Write-Host " - Workspace Direktori : $WorkspaceDir"
Write-Host " - Obsidian Vault      : $VaultDir"
Write-Host " - Aturan Sandbox & Agency Agents sudah terpasang di Hermes."
Write-Host " Langkah berikutnya:"
Write-Host " 1. Jalankan 9Router: 9router start"
Write-Host " 2. Pastikan alias 'hermes-default' dan 'hermes-code' aktif di 9router."
Write-Host " 3. Jalankan hermes: hermes"
Write-Host "==========================================================" -ForegroundColor Green
