# streamingwindowsinstall-livecd
An experimental way to install Windows by lazily mounting the Windows ISO from Microsoft.com

# Usage

Run a VM to test the OS using:

```sh
NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/16.03.tar.gz nix-build -A vm && result/bin/run-nixos-vm
```
