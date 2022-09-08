base:
	@sh base.sh

apps:
	@sh apps.sh

devtools:
	@sh dev-tools.sh

setup: base devtools apps

.DEFAULT_GOAL := setup
