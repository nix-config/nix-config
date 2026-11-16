boot-nixos *args:
    nh os boot . --diff full --ask {{args}}

clean *args:
    nh clean all --no-gcroots --ask {{args}}

format:
    treefmt .

show:
    fsn

switch-home *args:
    nh home switch . --diff full --ask {{args}}

switch-nixos *args:
    nh os switch . --diff full --ask {{args}}

update *args: 
    nix flake update {{args}}
