NAME =			redmine
VERSION =		latest
VERSION_ALIASES =	3.0.4 3.0 3
TITLE =			Redmine
DESCRIPTION =		Redmine is a flexible project management web application
SOURCE_URL =		https://github.com/scaleway-community/scaleway-redmine
DOC_URL =		https://scaleway.com/docs/getting-started-with-the-redmine-instant-apps/
VENDOR_URL =		http://www.redmine.org/
DEFAULT_IMAGE_ARCH =	x86_64


IMAGE_VOLUME_SIZE =	50G
IMAGE_BOOTSCRIPT =	stable
IMAGE_NAME =		Redmine 3.0.4


## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - https://j.mp/scw-builder | bash
-include docker-rules.mk
