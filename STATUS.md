# ocaml-stakeholder Status

- Role: selected next-20 local-only scaffold for OCaml
- Parity class: full-parity
- State: native-validated local deterministic tranche
- Rewrite completeness: 52%
- Functionality completeness: 34%
- Branch: `main`
- Active branch: `codex/baseline-2026-04-14-ocaml-stakeholder`
- Origin: `git@github.com:stakeholder-circus/ocaml-stakeholder.git`
- Upstream: `https://github.com/giacomo-b/rust-stakeholder`

## Evidence
- `ocaml -version`
- `dune --version`
- `opam exec -- ocamlformat --check src/catalog.ml src/json.ml src/runtime.ml bin/main.ml test/runtime_test.ml`
- `dune build @all`
- `dune runtest`
- `dune exec ocaml-stakeholder -- --list-values`
- same-seed deterministic output diff for `classic-six`
- explicit `--experimental-provider local-demo` fail-fast smoke

Docker validation is intentionally not claimed in this M1-safe pass.

## Blocks remaining
- Full live-provider/runtime support is deferred to the second-pass provider rollout wave.
- Publication is blocked until the publication/governance wave completes and remote access is available.

## Next
- Keep the deterministic tranche valid.
- Extend the second-pass provider wave after publication-governance clears.
- Preserve grouped fallback for later families.

## Canonical references
- `/Users/davidsupan/shareholder/stakeholder-core/docs/program/index.md`
- `/Users/davidsupan/shareholder/stakeholder-core/docs/program/next-20-wave.md`
