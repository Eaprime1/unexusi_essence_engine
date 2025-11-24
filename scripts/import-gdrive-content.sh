#!/bin/bash
# Import Content from Google Drive to SlimeTest
# Nano Entity: One file at a time, with logging
# ᚢᚾᛖᛉᚢᛋ-ᛈᚱᛁᛗᛖ-∞

# Configuration
GDRIVE_SLIMETEST="/home/sauron/pandora/gdrive_mounts/eaprime_prime_naught/slimetest"
SLIMETEST_ROOT="/home/sauron/pandora/slimetest"
LOG_FILE="$SLIMETEST_ROOT/logs/import_$(date +%Y%m%d_%H%M%S).log"
CHAIN_OF_CUSTODY="$SLIMETEST_ROOT/logs/chain_of_custody.json"

# Create logs directory
mkdir -p "$SLIMETEST_ROOT/logs"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Chain of custody entry
custody_log() {
    local action="$1"
    local file="$2"
    local source="$3"
    local dest="$4"

    # Append to chain of custody JSON
    echo "{\"timestamp\":\"$(date -Iseconds)\",\"action\":\"$action\",\"file\":\"$file\",\"source\":\"$source\",\"destination\":\"$dest\",\"user\":\"$USER\",\"host\":\"$(hostname)\"}" >> "$CHAIN_OF_CUSTODY"
}

# Initialize chain of custody if doesn't exist
if [ ! -f "$CHAIN_OF_CUSTODY" ]; then
    echo "[]" > "$CHAIN_OF_CUSTODY"
fi

log "========================================"
log "Google Drive Content Import - ONE HERTZ"
log "Import Session: $(date)"
log "========================================"

# Check if Google Drive is mounted
if [ ! -d "$GDRIVE_SLIMETEST" ]; then
    log "❌ ERROR: Google Drive not mounted at $GDRIVE_SLIMETEST"
    log "Run: gdrive-mount"
    exit 1
fi

log "✅ Google Drive mounted and accessible"

# Import nano concepts
log ""
log "📚 Importing Nano Concepts..."
if [ -f "$GDRIVE_SLIMETEST/nano_concepts_comprehensive.md" ]; then
    cp "$GDRIVE_SLIMETEST/nano_concepts_comprehensive.md" "$SLIMETEST_ROOT/docs/concepts/nano_concepts.md"
    custody_log "import" "nano_concepts.md" "$GDRIVE_SLIMETEST" "$SLIMETEST_ROOT/docs/concepts/"
    log "✅ nano_concepts.md imported"
else
    log "⚠️  nano_concepts_comprehensive.md not found"
fi

# Import flag system files
log ""
log "🏴 Importing Flag System..."
mkdir -p "$SLIMETEST_ROOT/docs/concepts/flags"

for i in 1 2 3; do
    if [ -f "$GDRIVE_SLIMETEST/flag system $i.txt" ]; then
        cp "$GDRIVE_SLIMETEST/flag system $i.txt" "$SLIMETEST_ROOT/docs/concepts/flags/flag_system_part$i.txt"
        custody_log "import" "flag_system_part$i.txt" "$GDRIVE_SLIMETEST" "$SLIMETEST_ROOT/docs/concepts/flags/"
        log "✅ flag_system_part$i.txt imported"
    else
        log "⚠️  flag system $i.txt not found"
    fi
done

# Import compass artifact
log ""
log "🧭 Importing Compass Artifact..."
COMPASS_FILE=$(find "$GDRIVE_SLIMETEST" -name "compass_artifact*.md" -print -quit 2>/dev/null)
if [ -n "$COMPASS_FILE" ]; then
    cp "$COMPASS_FILE" "$SLIMETEST_ROOT/docs/concepts/compass_physics_organization.md"
    custody_log "import" "compass_physics_organization.md" "$GDRIVE_SLIMETEST" "$SLIMETEST_ROOT/docs/concepts/"
    log "✅ compass artifact imported"
else
    log "⚠️  compass artifact not found"
fi

# Import GitHub content management strategy
log ""
log "📋 Importing GitHub Strategy..."
if [ -f "$GDRIVE_SLIMETEST/github_content_management_strategy.md" ]; then
    cp "$GDRIVE_SLIMETEST/github_content_management_strategy.md" "$SLIMETEST_ROOT/docs/guides/"
    custody_log "import" "github_content_management_strategy.md" "$GDRIVE_SLIMETEST" "$SLIMETEST_ROOT/docs/guides/"
    log "✅ github_content_management_strategy.md imported"
else
    log "⚠️  github_content_management_strategy.md not found"
fi

# Import consolidation guides
log ""
log "📖 Importing Consolidation Guides..."
for guide in "SDWG_Consolidation_Plan.md" "Thematic_Consolidation_Procedure_Guide.md" "Master_Thread_Opening_Messages.md"; do
    if [ -f "$GDRIVE_SLIMETEST/$guide" ]; then
        cp "$GDRIVE_SLIMETEST/$guide" "$SLIMETEST_ROOT/docs/concepts/"
        custody_log "import" "$guide" "$GDRIVE_SLIMETEST" "$SLIMETEST_ROOT/docs/concepts/"
        log "✅ $guide imported"
    else
        log "⚠️  $guide not found"
    fi
done

# Import quantum signature manifest
log ""
log "∰ Importing Quantum Signature..."
if [ -f "$GDRIVE_SLIMETEST/∰◊€π¿ ∞.txt" ]; then
    cp "$GDRIVE_SLIMETEST/∰◊€π¿ ∞.txt" "$SLIMETEST_ROOT/docs/concepts/quantum_signature_manifest.txt"
    custody_log "import" "quantum_signature_manifest.txt" "$GDRIVE_SLIMETEST" "$SLIMETEST_ROOT/docs/concepts/"
    log "✅ quantum signature manifest imported"
else
    log "⚠️  quantum signature manifest not found"
fi

# Import conversation constellation
log ""
log "🌌 Importing Conversation Constellation..."
if [ -f "$GDRIVE_SLIMETEST/conversation_constellation_map.md" ]; then
    cp "$GDRIVE_SLIMETEST/conversation_constellation_map.md" "$SLIMETEST_ROOT/docs/concepts/"
    custody_log "import" "conversation_constellation_map.md" "$GDRIVE_SLIMETEST" "$SLIMETEST_ROOT/docs/concepts/"
    log "✅ conversation_constellation_map.md imported"
else
    log "⚠️  conversation_constellation_map.md not found"
fi

# Summary
log ""
log "========================================"
log "Import Complete"
log "========================================"
log "Log file: $LOG_FILE"
log "Chain of custody: $CHAIN_OF_CUSTODY"
log ""
log "Imported files are in:"
log "  - docs/concepts/ (conceptual frameworks)"
log "  - docs/concepts/flags/ (flag system)"
log "  - docs/guides/ (GitHub strategy)"
log ""
log "Next steps:"
log "  1. Review imported files"
log "  2. Clean up filenames if needed"
log "  3. Create nano entities for file processing"
log ""
log "∰◊€π¿🌌∞ ONE HERTZ - One file at a time"
