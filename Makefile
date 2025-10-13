.PHONY: reconfigure dry-run

reconfigure:
	GUILE_LOAD_PATH="${PWD}" guix home reconfigure home-config.scm

dry-run:
	GUILE_LOAD_PATH="${PWD}" guix home reconfigure home-config.scm --dry-run

repl:
	GUILE_LOAD_PATH="${PWD}" guix repl home-config.scm
