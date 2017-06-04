PHP 7.1 - Apache Edition
========================

**Code directory**

The application code (index.php) is expected to be in this folder.

```
/data/app
```

**Config**

Configuration is presented to these containers via files on the commandline.

Frameworks like Kubernetes support this with Secret or ConfigMap APIs. This can also be
achieved with a simple volume mount and `echo foo > bar`.

```
/etc/skpr
```

This is used for:

* Temporarily turning off health checks
* Turning on New Relic
* Setting in application configuration
*  

**Environment variables**

See https://github.com/previousnext/tuner for more information.

* TUNER_MAX - The maximum amount of memory available
* TUNER_PROC - The max memory per process
* TUNER_MULTIPLIER - A method of boosting how many procs can be run
