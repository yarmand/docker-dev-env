# docker-dev-env

This project attempt to setup an ubuntu based dev environment which will be usable on any
system Windows / osx 

It use named volumes to get persistence between the runs.

## setup
Create or put your standard ssh public key in the file `id_rsa.pub`.

This file will be copy as /root/.ssh/authorized_keys to enable you to ssh in the container.

## goodies
- mount the host docker socket so you can use docker from inside the container
- by default it start a container with ssH daemon
     - `ssh -p 9022 root@localhost`
- `/src` is a persistent volume
- `/opt` is a persistent volume
- `/root` this is you home directory, it is persistent
- on windows
  - mount `c:\` in `/mnt/c`
- on mac
  - mount `/Volumes/Users` in `/mnt/users`

# run it
```
start.sh or start.bat
```
## connect to the container
```
ssh -p 9022 root@localhost
```

## copy files in the container
```
docker cp my_folder docker-dev-env:/src/my_folder
```

## copy files out of hte container
```
docker cp docker-dev-env:/src/some_place/output.txt output.txt
```
## export a volume
you can export one of the volumes mounted in `/src` `/opt` and `/root` with a command like:
```
$ docker run --rm --volumes-from docker-dev-env -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /src
```

# TODO
- example on how to export persisten volumes as .tar.gz
