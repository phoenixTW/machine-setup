base:
	@sh base.sh

apps:
	@sh apps.sh

devtools:
	@sh dev-tools.sh

misc:
	@sh misc.sh

setup: base devtools apps misc

.DEFAULT_GOAL := setup
