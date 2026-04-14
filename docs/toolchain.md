# OCaml Toolchain

- State: deterministic first tranche implemented
- Toolchain source: `built-in`

## Native commands
- `ocaml -version`
- `dune --version`
- `opam exec -- ocamlformat --version`
- `opam exec -- ocamlformat --check src/catalog.ml src/json.ml src/runtime.ml bin/main.ml test/runtime_test.ml`
- `dune build @all`
- `dune runtest`

## Docker commands
- `docker build -t ocaml-stakeholder .`
- `docker run --rm ocaml-stakeholder --list-values`
- `docker run --rm ocaml-stakeholder --seed 7 --family classic-six`
- `docker run --rm ocaml-stakeholder --seed 7 --family modern-core`
- `docker run --rm ocaml-stakeholder --seed 7 --family later-fallback`
- `docker run --rm ocaml-stakeholder --experimental-provider openai`
