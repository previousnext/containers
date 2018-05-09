Containers
==========

[![CircleCI](https://circleci.com/gh/previousnext/containers.svg?style=svg)](https://circleci.com/gh/previousnext/containers)

The official container suite for PreviousNext inhouse container management solution, Skipper.

Goals:

* Leverage official Docker Hub containers as a base.
* Provide close Prod to Local configurations, this is done by leveraging the hosting container as a base container for `dev` images.

Documentation for each container can be found in its respective directory.

## Building

Each container has a Makefile in its directory with the workflow:

```bash
# Build all versions
make

# Release to Docker Hub
make release
```