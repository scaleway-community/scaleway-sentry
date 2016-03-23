NAME =			sentry
VERSION =		latest
VERSION_ALIASES =	8.2.3 8.2 8
TITLE =			sentry
DESCRIPTION =		Sentry is cross-platform crash reporting built with love https://getsentry.com
DOC_URL =
SOURCE_URL =		https://github.com/scaleway-community/scaleway-sentry
VENDOR_URL =		https://getsentry.com/welcome/
DEFAULT_IMAGE_ARCH =	x86_64


IMAGE_VOLUME_SIZE =	50G
IMAGE_BOOTSCRIPT =	latest
IMAGE_NAME =		Sentry 8


## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk
