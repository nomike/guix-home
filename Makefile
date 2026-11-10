.PHONY: reconfigure dry-run repl

reconfigure:
	guix home reconfigure home-config.scm

dry-run:
	guix home reconfigure home-config.scm --dry-run

repl:
	guix repl home-config.scm
