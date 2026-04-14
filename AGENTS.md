# ocaml-stakeholder AGENTS

- Preserve imported Rust history and provenance.
- First tranche target is deterministic `classic-six + modern-core` with grouped fallback for later families.
- CLI contract: `--list-values`, `--family`, `--seed`, `--output-format json`, and `--experimental-provider` fail-fast.
- Missing behavior must fail fast and be recorded in `GAPS.md`.
- No placeholder runtime behavior remains once implementation starts.
- Full live-provider/runtime support is a required second-pass wave.

## Native promotion commands
- `ocaml -version`
- `dune --version`
- `opam exec -- ocamlformat --version`
- `opam exec -- ocamlformat --check src/catalog.ml src/json.ml src/runtime.ml bin/main.ml test/runtime_test.ml`
- `dune build @all`
- `dune runtest`
- `python3 scripts/validate_scaffold.py`
- `docker build -t ocaml-stakeholder .`
- `docker run --rm ocaml-stakeholder --list-values`
- `docker run --rm ocaml-stakeholder --experimental-provider openai`
