.PHONY: switch
switch:
	sudo nixos-rebuild switch
.PHONY: clean
clean:
	nix-collect-garbage -d
