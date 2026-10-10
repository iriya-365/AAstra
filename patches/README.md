# Patches for AAstra

These patches are applied automatically by `buildScript/lib/core/get_source.sh` when fetching dependencies:

- `libneko.patch` — runtime log toggling (target: starifly/libneko@6a85c185)
- `sing-vmess.patch` — VLESS encryption resource leak fixes (target: starifly/sing-vmess@887f058c)
- `sing-box.patch` — additional sing-box changes (target: SagerNet/sing-box@7054cac5) — **upload this large file manually if missing**
- `MasterDnsVPN.patch` — Nekobox+ support (target: masterking32/MasterDnsVPN@7de2476f) — **upload manually if missing**
- `NekoBoxForAndroid.patch` — main app changes (target base: starifly/NekoBoxForAndroid@5bb4786) — apply on the correct base commit; current main is newer

See `get_source_env.sh` for pinned commits.
