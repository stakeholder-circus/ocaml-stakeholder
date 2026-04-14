from __future__ import annotations

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

REQUIRED = [
    "AGENTS.md",
    "README.md",
    "STATUS.md",
    "GAPS.md",
    "PARITY.md",
    "AI_DISCLOSURE.md",
    "docs/remotes.md",
    "docs/provenance.md",
    "docs/toolchain.md",
    "docs/traceability/first-push-families.md",
    "dune-project",
    "ocaml-stakeholder.opam",
    "src/dune",
    "src/catalog.ml",
    "src/json.ml",
    "src/runtime.ml",
    "bin/dune",
    "bin/main.ml",
    "test/dune",
    "test/runtime_test.ml",
    ".ocamlformat",
    ".githooks/commit-msg",
    ".githooks/pre-push",
    ".github/CODEOWNERS",
    ".github/PULL_REQUEST_TEMPLATE.md",
    ".github/dependabot.yml",
    ".github/workflows/actionlint.yml",
    ".github/workflows/dependency-review.yml",
    ".github/workflows/ci.yml",
    ".github/workflows/ci-native.yml",
    ".github/workflows/docker-smoke.yml",
    "flake.nix",
    "Dockerfile",
    "flake.lock",
]

OCAMLFORMAT_FILES = [
    "src/catalog.ml",
    "src/json.ml",
    "src/runtime.ml",
    "bin/main.ml",
    "test/runtime_test.ml",
]


def run(command: list[str]) -> None:
    subprocess.run(command, cwd=ROOT, check=True)


def main() -> int:
    missing = [path for path in REQUIRED if not (ROOT / path).exists()]
    if missing:
        raise SystemExit(f"missing tranche files: {', '.join(missing)}")

    run(["ocaml", "-version"])
    run(["dune", "--version"])
    run(["opam", "exec", "--", "ocamlformat", "--version"])
    run(["opam", "exec", "--", "ocamlformat", "--check", *OCAMLFORMAT_FILES])
    run(["dune", "build", "@all"])
    run(["dune", "runtest"])
    run(["docker", "build", "-t", "ocaml-stakeholder", "."])
    run(["docker", "run", "--rm", "ocaml-stakeholder", "--list-values"])
    run(["docker", "run", "--rm", "ocaml-stakeholder", "--seed", "7", "--family", "classic-six"])
    run(["docker", "run", "--rm", "ocaml-stakeholder", "--seed", "7", "--family", "modern-core"])
    run(["docker", "run", "--rm", "ocaml-stakeholder", "--seed", "7", "--family", "later-fallback"])
    failed = subprocess.run(
        ["docker", "run", "--rm", "ocaml-stakeholder", "--experimental-provider", "openai"],
        cwd=ROOT,
    )
    if failed.returncode == 0:
        raise SystemExit("experimental provider should fail fast")

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
