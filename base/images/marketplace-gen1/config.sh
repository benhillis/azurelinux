#!/bin/bash
# KIWI config.sh — post-bootstrap customization for marketplace-gen1.
# Port of the azl3.0 marketplace PostInstallScript
# additionalconfigs/configure-systemd-networkd.sh.
set -euo pipefail

# Clear the default DHCP network unit so image networking is managed by the
# cloud-init / systemd-networkd configuration shipped with the image.
if [[ -f "/etc/systemd/network/99-dhcp-en.network" ]]; then
    echo "Truncating /etc/systemd/network/99-dhcp-en.network"
    truncate -s 0 /etc/systemd/network/99-dhcp-en.network
fi
