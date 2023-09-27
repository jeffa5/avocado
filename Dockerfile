FROM nixos/nix

ARG platform

WORKDIR /build
COPY . .

RUN nix develop . --extra-experimental-features "nix-command flakes" --command bash -c "./build.sh ${platform}"

WORKDIR /app
