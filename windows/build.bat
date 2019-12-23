docker pull docker.pkg.github.com/yarmand/docker-dev-env || echo 'cannot pull the image you may want to do: docker login docker.pkg.github.com'

docker build -t docker.pkg.github.com/yarmand/docker-dev-env ..
