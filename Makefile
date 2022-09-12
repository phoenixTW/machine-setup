base:
	@sh base.sh

apps:
	@sh apps.sh

devtools:
	@sh dev-tools.sh

misc:
	@zsh misc.sh

setup: base devtools apps misc

.DEFAULT_GOAL := setup
