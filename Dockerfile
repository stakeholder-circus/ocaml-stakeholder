FROM ocaml/opam:debian-12-ocaml-5.2 AS build
WORKDIR /home/opam/ocaml-stakeholder
COPY --chown=opam:opam . .
RUN opam update && opam install -y dune ocamlformat && opam exec -- dune build @all && opam exec -- dune runtest

FROM debian:12-slim
RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=build /home/opam/ocaml-stakeholder/_build/default/bin/main.exe /usr/local/bin/ocaml-stakeholder
ENTRYPOINT ["/usr/local/bin/ocaml-stakeholder"]
