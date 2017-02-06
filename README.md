# docker-dev-env

This project attempt to setup an ubuntu based dev environment which will be usable on any
system Windows / osx / linux.

It use named volumes to get persistence between the runs.

## goodies
- integrated docker-compose client that talk directly to the host demon.
- by default it start a container with ssH daemon
     - `ssh -p 9022 root@localhost`
- Source code
  - `/src` is a persistent volume
  - `/src/host` mounted from the host
- `/opt` is a persistent volume
- `/root` this is you home directory, it is persistent

# run it
```
docker-compose up --build
```
## connect permanent container
```
ssh -p 9022 root@localhost
```

## one off shell
```
# on OSX/linux
docker-compose run --rm devenv /usr/bin/zsh

# on windows
winpty docker-compose run --rm devenv //usr/bin/zsh
```
# TODO
- example on how to export persisten volumes as .tar.gz
- helper function to translate path into the dev container compatible
    with mobilux mounted to run docker command easily.
