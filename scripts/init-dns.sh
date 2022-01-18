#!/usr/bin/env bash
set -euo pipefail
cp /etc/resolv.conf /etc/resolv.conf.bak
echo 'search default.svc.cluster.local svc.cluster.local cluster.local' > /etc/resolv.conf
echo 'nameserver 8.8.8.8' >> /etc/resolv.conf # node peering can have issues with the built-in DNS
echo 'options ndots:5' >> /etc/resolv.conf
