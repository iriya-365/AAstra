#!/bin/bash
set -e

source "buildScript/init/env.sh"
ENV_NB4A=1
source "buildScript/lib/core/get_source_env.sh"
ROOT="$(pwd)"
LIBNEKO_PATCH="$ROOT/patches/libneko.patch"
SING_BOX_PATCH="$ROOT/patches/sing-box.patch"
SING_VMESS_PATCH="$ROOT/patches/sing-vmess.patch"
MASTER_DNS_VPN_PATCH="$ROOT/patches/MasterDnsVPN.patch"
pushd ..

####

if [ ! -d "sing-box" ]; then
  git clone --no-checkout https://github.com/SagerNet/sing-box.git sing-box
fi
pushd sing-box
if [ "$(git rev-parse HEAD 2>/dev/null || true)" != "$COMMIT_SING_BOX" ]; then
  git fetch origin "$COMMIT_SING_BOX" || git fetch --depth 1 origin "$COMMIT_SING_BOX"
  git checkout "$COMMIT_SING_BOX"
  if [ -f "$SING_BOX_PATCH" ]; then git apply "$SING_BOX_PATCH" || true; fi
fi
popd

####

if [ ! -d "sing-vmess" ]; then
  git clone --no-checkout https://github.com/starifly/sing-vmess.git sing-vmess
fi
pushd sing-vmess
if [ "$(git rev-parse HEAD 2>/dev/null || true)" != "$COMMIT_SING_VMESS" ]; then
  git fetch origin "$COMMIT_SING_VMESS" || git fetch --depth 1 origin "$COMMIT_SING_VMESS"
  git checkout "$COMMIT_SING_VMESS"
  if [ -f "$SING_VMESS_PATCH" ]; then git apply "$SING_VMESS_PATCH" || true; fi
fi
popd

####

if [ ! -d "libneko" ]; then
  git clone --no-checkout https://github.com/starifly/libneko.git libneko
fi
pushd libneko
if [ "$(git rev-parse HEAD 2>/dev/null || true)" != "$COMMIT_LIBNEKO" ]; then
  git fetch origin "$COMMIT_LIBNEKO" || git fetch --depth 1 origin "$COMMIT_LIBNEKO"
  git checkout "$COMMIT_LIBNEKO"
  if [ -f "$LIBNEKO_PATCH" ]; then git apply "$LIBNEKO_PATCH" || true; fi
fi
popd

####

if [ ! -d "MasterDnsVPN" ]; then
  git clone --no-checkout https://github.com/masterking32/MasterDnsVPN.git MasterDnsVPN
fi
pushd MasterDnsVPN
if [ "$(git rev-parse HEAD 2>/dev/null || true)" != "$COMMIT_MASTER_DNS_VPN" ]; then
  git fetch origin "$COMMIT_MASTER_DNS_VPN" || git fetch --depth 1 origin "$COMMIT_MASTER_DNS_VPN"
  git checkout "$COMMIT_MASTER_DNS_VPN"
  if [ -f "$MASTER_DNS_VPN_PATCH" ]; then git apply "$MASTER_DNS_VPN_PATCH" || true; fi
fi
popd

####

popd
