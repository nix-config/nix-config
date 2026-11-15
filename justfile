boot-nixos *args:
    nh os boot . --ask {{args}}

clean *args:
    nh clean all --no-gcroots --ask {{args}}

format:
    treefmt .

show:
    fsn

switch-home *args:
    nh home switch . --ask {{args}}

switch-nixos *args:
    nh os switch . --ask {{args}}

update *args: 
    nix flake update {{args}}
