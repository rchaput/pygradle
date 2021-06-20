TAG="rchaput/pygradle:liberica"

# This command builds the x86-64 version and loads it into the docker daemon
build-amd64: Dockerfile
	docker buildx build --load --platform linux/amd64 -t ${TAG} .

# This command builds the arm64 version and loads it into the docker daemon
build-arm64: Dockerfile
	docker buildx build --load --platform linux/arm64 -t ${TAG} .

# This command builds both versions and pushes them to Docker Hub
# Docker daemon does NOT support loading multiple architectures
build-all: Dockerfile
	docker buildx build --push --platform linux/amd64,linux/arm64 -t ${TAG} .

