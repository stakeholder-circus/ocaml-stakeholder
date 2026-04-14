> [!WARNING]
> This repository is AI-assisted and manually reviewed. It now contains the deterministic first tranche for the OCaml rewrite wave.

# ocaml-stakeholder

OCaml deterministic tranche under stakeholder-circus.

## Status
- First deterministic tranche implemented locally.
- Local-only scaffold policy remains in force; no upstream tracking and no publication yet.
- Default branch remains `main`; active work happens on the repo-specific baseline branch.

## Role
- Deterministic full-parity target for the next-20 wave.
- Tranche 1 is `classic-six + modern-core` with grouped fallback for later families.
- Full live-provider/runtime support remains a required follow-on wave.

## CLI contract
- `--list-values`
- `--family <name|classic-six|modern-core|later-fallback>`
- `--seed <int>`
- `--output-format json`
- `--experimental-provider <name>` fails fast

## Planned toolchain contract
- Toolchain source: `built-in`
- See [docs/toolchain.md](docs/toolchain.md) for exact native and Docker commands.

## Current guardrail
- Missing behavior must fail fast and be recorded in `GAPS.md`.
- No placeholder runtime behavior remains in the deterministic tranche.
- Full live-provider/runtime support is deferred to the second-pass provider rollout wave.

## Documentation
- [STATUS.md](STATUS.md)
- [PARITY.md](PARITY.md)
- [GAPS.md](GAPS.md)
- [docs/remotes.md](docs/remotes.md)
- [docs/provenance.md](docs/provenance.md)
- [docs/toolchain.md](docs/toolchain.md)
- [docs/traceability/first-push-families.md](docs/traceability/first-push-families.md)
