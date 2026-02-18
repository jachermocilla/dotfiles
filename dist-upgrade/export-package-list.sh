#!/bin/bash
# =============================================================================
# export_packages.sh
# Exports manually installed Ubuntu packages for reinstallation after upgrade
# =============================================================================

OUTPUT_FILE="${1:-packages_$(lsb_release -cs)_$(date +%Y%m%d).txt}"

echo "Exporting installed packages to: $OUTPUT_FILE"

# Get packages explicitly installed by the user (excludes auto-installed deps)
comm -23 \
  <(apt-mark showmanual | sort) \
  <(apt list --installed 2>/dev/null | grep -E '\[installed,automatic\]' | cut -d'/' -f1 | sort) \
  > "$OUTPUT_FILE"

echo "Done! $(wc -l < "$OUTPUT_FILE") packages exported to: $OUTPUT_FILE"
echo ""
echo "To reinstall on your new system, run:"
echo "  sudo apt update && xargs sudo apt install -y < $OUTPUT_FILE"
