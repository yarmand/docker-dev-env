---
OBSOLETE README ... NEED A COMPLETE REWRITE
---
# docker-dev-env

This project attempt to setup an ubuntu based dev environment which will be usable on any
system Windows / osx 

It use named volumes to get persistence between the runs.

## setup
###SSH connection to the container.
The container will use you `~/.ssh.id_rsa.pub` file into `/root/.ssh/authorized_keys`


## goodies
- mount the host docker socket so you can use docker from inside the container
- by default it start a container with ssH daemon on port 9022
     - `ssh -p 9022 root@localhost`
- `/src` is a persistent volume
- `/opt` is a persistent volume
- `/root` this is you home directory, it is persistent
- on windows
  - mount `c:\` in `/mnt/c`
- on mac
  - mount `/Volumes/Users` in `/mnt/users`
- persistent volumes are SAMBA exposed on the docker VM IP. They can be mounted with 
    - /src => \\10.75.0.2\SRC
    - /root => \\10.75.0.2\HOME
    - /opt => \\10.75.0.2\OPT
- 

# run it
```
start.sh or start.bat
```
## connect to the container
```
ssh -p 9022 root@localhost
```

## copy files in the container
**Using Samba:**
- /src => \\10.75.0.2\SRC
- /root => \\10.75.0.2\HOME
- /opt => \\10.75.0.2\OPT

**user docker:**
```
docker cp my_folder docker-dev-env:/src/my_folder
```

## copy files out of the container
**using samba:** (see above)

**user docker**
```
docker cp docker-dev-env:/src/some_place/output.txt output.txt
```
## export a volume
you can export one of the volumes mounted in `/src` `/opt` and `/root` with a command like:
```
$ docker run --rm --volumes-from docker-dev-env -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /src
```
