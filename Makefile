DOCKER_NAMESPACE =	armbuild/
NAME =			scw-app-redmine
VERSION =		latest
VERSION_ALIASES =	14.10 14 latest utopic
TITLE =			Redmine
DESCRIPTION =		Redmine is a flexible project management web application
SOURCE_URL =		https://github.com/scaleway/image-app-redmine
DOC_URL =		https://scaleway.com/docs/getting-started-with-the-redmine-instant-apps/
IMAGE_VOLUME_SIZE =	50G

## Image tools  (https://github.com/scaleway/image-tools)
all:	docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk


## Here you can add custom commands and overrides
