SFTP - Developer Edition
========================

**Usage**

As a developer you will need to build a new container off this as a base.

You will need to following directory structure:

```
project-name
└── ...                       # Usual project repo structure.
└── dockerfiles
    └── sftp
        ├── Dockerfile        # Where we do the extending.
        └── authorized_keys   # Public keys used for authentication.
```

The Dockerfile will look like this:

```
FROM  previousnext/sftp
LABEL maintainer="you@yourdomain.com"
```

Now build the container and run it:

```
# Build.
docker build -t previousnext/my-project-sftp:latest ./project-name/dockerfiles/sftp

# Run in daemon mode.
docker run -d -P --name my-project-sftp previousnext/my-project-sftp:latest
```

To test it is working:

```
# Find exposed ports.
docker port $(docker ps -aqf "name=my-project-sftp")

# Take port from the end of previous output (i.e. 22/tcp -> 0.0.0.0:32769)
ssh dev@localhost -i /path/to/private/key -p32769

# You should get a message like:
#   This service allows sftp connections only
```
