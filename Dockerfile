FROM alpine:3.20
LABEL org.opencontainers.image.title="ocaml-stakeholder"
LABEL org.opencontainers.image.description="Scaffold-only placeholder container for ocaml-stakeholder"
CMD ["sh", "-lc", "echo 'ocaml-stakeholder scaffold-only baseline';"]
