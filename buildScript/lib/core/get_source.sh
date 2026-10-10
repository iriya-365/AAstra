#!/bin/bash
set -e

source "buildScript/init/env.sh"
ENV_NB4A=1
source "buildScript/lib/core/get_source_env.sh"
ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
LIBNEKO_PATCH="$ROOT/patches/libneko.patch"
SING_BOX_PATCH="$ROOT/patches/sing-box.patch"
SING_VMESS_PATCH="$ROOT/patches/sing-vmess.patch"
MASTER_DNS_VPN_PATCH="$ROOT/patches/MasterDnsVPN.patch"
pushd ..

checkout_and_patch() {
  local dir="$1"
  local url="$2"
  local commit="$3"
  local patch="$4"

  if [ ! -d "$dir/.git" ]; then
    rm -rf "$dir"
    git clone "$url" "$dir"
  fi
  pushd "$dir"
  git fetch origin "$commit" 2>/dev/null || git fetch --depth 1 origin "$commit" || git fetch origin
  git checkout -f "$commit"
  git reset --hard "$commit"
  # drop previous apply state if any
  git clean -fdx -e .git 2>/dev/null || true
  if [ -n "$patch" ] && [ -f "$patch" ]; then
    echo ">> applying $(basename "$patch") to $dir"
    git apply --whitespace=nowarn "$patch" || git apply --3way --whitespace=nowarn "$patch" || true
  fi
  popd
}

checkout_and_patch sing-box https://github.com/SagerNet/sing-box.git "$COMMIT_SING_BOX" "$SING_BOX_PATCH"
checkout_and_patch sing-vmess https://github.com/starifly/sing-vmess.git "$COMMIT_SING_VMESS" "$SING_VMESS_PATCH"
checkout_and_patch libneko https://github.com/starifly/libneko.git "$COMMIT_LIBNEKO" "$LIBNEKO_PATCH"
checkout_and_patch MasterDnsVPN https://github.com/masterking32/MasterDnsVPN.git "$COMMIT_MASTER_DNS_VPN" "$MASTER_DNS_VPN_PATCH"

popd
