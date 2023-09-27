{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  };

  outputs = {
    nixpkgs,
    self,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    kernel = pkgs.linuxPackages_4_14.kernel;
  in {
    packages.${system}.avocado = pkgs.gcc9Stdenv.mkDerivation {
      src = ./.;
      name = "avocado";

      hardeningDisable = ["fortify"];
      NIX_CFLAGS_COMPILE = "-march=native";
      NIXOS_KERNELDIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";
      RTE_KERNELDIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";

      buildInputs = with pkgs; [
        cmake
        fmt
        glog
        folly
        openssl
        boost
        jemalloc
        double-conversion
        numactl
        libevent
        gflags
        docopt_cpp
        ninja
      ];
    };

    devShells.${system}.default = pkgs.mkShell.override {stdenv = pkgs.gcc9Stdenv;} {
      hardeningDisable = ["fortify"];
      NIX_CFLAGS_COMPILE = "-march=native";
      NIXOS_KERNELDIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";
      RTE_KERNELDIR = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build";
      packages = with pkgs; [
        cmake
        fmt
        glog
        folly
        openssl
        boost
        jemalloc
        double-conversion
        numactl
        libevent
        gflags
        docopt_cpp
        ninja
      ];
    };
  };
}
