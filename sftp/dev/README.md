SFTP - Developer Edition
========================

**Usage**

As a developer you will need to build a new container off this as a base.

You will need to following directory structure:

```
# Where we do the extending.
* Dockerfile

# Container an ssh public key used for authentication.
* authorized_keys
```

The Dockerfile will look like this:

```
FROM       previousnext/sftp:latest
MAINTAINER YOUR NAME
```

Now we build the container and run it:

```
# Build
docker build -t previousnext/my-project-sftp:latest .

# Run
docker run -it previousnext/my-project-sftp:latest
```
