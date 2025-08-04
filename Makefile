.PHONY: reconfigure

reconfigure:
	GUILE_LOAD_PATH="${PWD}" guix home reconfigure home-config.scm
