> [!NOTE]
> Missing or deferred behavior must fail fast and be tracked explicitly. No placeholder behavior should mask absent parity work.

# OCaml Gaps

## Current explicit gaps
- `ocaml-stakeholder.foundation-pending`: deterministic scheduler, CLI wiring, and runtime skeleton are not implemented yet.
- `ocaml-stakeholder.classic-six-pending`: classic-six dedicated renderer depth is not implemented yet.
- `ocaml-stakeholder.modern-core-pending`: modern-core dedicated renderer depth is not implemented yet.
- `ocaml-stakeholder.post-modern-core-pending`: later packet families remain unimplemented.
- `ocaml-stakeholder.traceability-rows-pending`: traceability rows will be added when real behavior is promoted from scaffold to implementation.
- `ocaml-stakeholder.codeql-activation-pending`: CodeQL activation is deferred until the repo contains source-bearing implementation files in a supported language.
- `ocaml-stakeholder.flake-lock-pending`: `flake.nix` is present, but `flake.lock` was not generated during scaffold bootstrap because `nix` is unavailable in the current local environment.

## Guardrail
- Do not present this scaffold as an implementation-complete parity port.
