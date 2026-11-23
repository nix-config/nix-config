boot-nixos *args:
    nh os boot . --diff full --ask {{ args }}

buid-home user *args:
    rom build .#homeConfigurations.{{ user }}.config.home.activationPackage -- --out-link result/home/{{ user }} {{ args }}

buid-nixos host *args:
    rom build .#nixosConfigurations.{{ host }}.config.system.build.toplevel -- --out-link result/nixos/{{ host }} {{ args }}

clean *args:
    nh clean all --no-gcroots --ask {{ args }}

format:
    just --fmt
    treefmt .

show:
    fsn

switch-home *args:
    nh home switch . --diff full --ask {{ args }}

switch-nixos *args:
    nh os switch . --diff full --ask {{ args }}

switch-home-remote user host *args:
    #!/usr/bin/env bash
    set -euo pipefail
    generation="$(rom build ".#homeConfigurations.{{ user }}.activationPackage" -- --no-link --print-out-paths {{ args }})"
    nix copy --to "ssh://{{ user }}@{{ host }}" "$generation"
    ssh "{{ user }}@{{ host }}" "$generation/activate"

switch-nixos-remote user host *args:
    nh os switch . --diff full --ask --target-host {{ user }}@{{ host }} {{ args }}

update *args:
    nix flake update {{ args }}
