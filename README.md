# docker-dev-env

This project attempt to setup an ubuntu based dev environment which will be usable on any
system Windows / osx / linux.

It use named volumes to get persistence between the runs.

## goodies
- integrated docker client that talk directly to the host demon so you
    can run docker command inside the container
- by default it run a ssh demon you can easily connect to
    - username: developer
    - you need to provide a file names `id_rsa.pub` to be used as
        authorised key for user developer
    - connect via `ssh -p 9022 developer@localhost`
- home directory `/home/developer`
  - is is persistent
  - ---you can access it via samba---
- exchange with host `/home/windows`
  - you need to update the absolute path into docker-compose.yml
- `/opt` directory is persistent


# run it
```
docker-compose up
```

# change it
add some software to the Dockerfile and restart via
```
docker-compose up --build
```

