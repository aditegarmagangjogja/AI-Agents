#!/usr/bin/env bash
set -e

echo "=========================================================="
echo "   HERMES + 9ROUTER + OBSIDIAN ECOSYSTEM SETUP (LINUX/VPS)"
echo "=========================================================="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$SCRIPT_DIR/workspace"
VAULT_DIR="$SCRIPT_DIR/vault"
HERMES_DIR="$HOME/.hermes"

# 1. Inisialisasi folder
mkdir -p "$WORKSPACE_DIR"
if [ ! -d "$VAULT_DIR" ]; then
    echo "[1/4] Menginisialisasi Vault Markdown..."
    cp -r "$SCRIPT_DIR/vault-template" "$VAULT_DIR"
fi

# 2. Setup Direktori Hermes
echo "[2/4] Menyiapkan direktori Hermes ($HERMES_DIR)..."
mkdir -p "$HERMES_DIR/plugins" "$HERMES_DIR/memories"

# 3. Copy Plugin Agency Agents
echo "[3/4] Memasang Agency Agents Router..."
cp -r "$SCRIPT_DIR/hermes/plugins/agency-agents-router" "$HERMES_DIR/plugins/"

# 4. Render Template SOUL, Config, Memory
echo "[4/4] Mengonfigurasi SOUL.md, Config, dan Memories..."

sed -e "s|{{WORKSPACE_DIR}}|$WORKSPACE_DIR|g" \
    -e "s|{{VAULT_DIR}}|$VAULT_DIR|g" \
    "$SCRIPT_DIR/hermes/SOUL.template.md" > "$HERMES_DIR/SOUL.md"

sed -e "s|{{WORKSPACE_DIR}}|$WORKSPACE_DIR|g" \
    -e "s|{{VAULT_DIR}}|$VAULT_DIR|g" \
    "$SCRIPT_DIR/hermes/memories/MEMORY.template.md" > "$HERMES_DIR/memories/MEMORY.md"

sed -e "s|{{VAULT_DIR}}|$VAULT_DIR|g" \
    "$SCRIPT_DIR/hermes/memories/USER.template.md" > "$HERMES_DIR/memories/USER.md"

if [ ! -f "$HERMES_DIR/config.yaml" ]; then
    cp "$SCRIPT_DIR/hermes/config.template.yaml" "$HERMES_DIR/config.yaml"
else
    echo "  -> config.yaml sudah ada. Template disalin ke $HERMES_DIR/config.dist.yaml"
    cp "$SCRIPT_DIR/hermes/config.template.yaml" "$HERMES_DIR/config.dist.yaml"
fi

echo "=========================================================="
echo " Setup Selesai!"
echo " - Workspace : $WORKSPACE_DIR"
echo " - Vault     : $VAULT_DIR"
echo " Langkah berikutnya:"
echo " 1. Pastikan 9Router berjalan: 9router start"
echo " 2. Pastikan alias 'hermes-default' dan 'hermes-code' aktif di 9Router."
echo " 3. Jalankan hermes: hermes"
echo "=========================================================="
