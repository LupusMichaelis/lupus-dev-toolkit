# Lupus' DevOps toolkit

This is a serie of tools for the developer lost in DevOps.

# Contributions

You're welcome to contribute. There is no proper guidelines or anything yet, feel free to
provide for it, and go through the
[project](/LupusMichaelis/lupus-dev-toolkit/projects/1)
to see what is to be done.

# Internals

## Ygor

`./bin/ygor` is a script providing shorthands for daily common tasks. Invoking it without
argument triggers the usage message. I usually make in an alias `y` to it.

## Helpers

Found in `./helpers`.

A library of helper functions to load in interactive sessions.

* `csv`: manipulate spreadsheets from the command line
* `curl`: [cUrl](https://curl.se/) session helpers (oauth token management)
* `json`: manipulation of [JSON](https://www.json.org/json-en.html) payloads
* `mkdir-cd`: make a directory and jump into it

## Docker images

[![pipeline status](https://gitlab.com/LupusMichaelis/lupus-dev-toolkit/badges/trunk/pipeline.svg)](https://gitlab.com/LupusMichaelis/lupus-dev-toolkit/-/commits/trunk)

Images are defined in various directories listed under `build`.

The `./bin/build-images` script helps to build, sign and push images to
[Docker Hub](https://hub.docker.com/u/lupusmichaelis).

There is currently 2 different image flavours:

* hacking time images:
  images designed to embed tools for development and to be easy the use with bind mount
* shipping time images:
  images designed to be lean and secured, for safe shipping of your hand-crafted marvel

### Igor

A bare base image to embed in-container shell script helpers. Used to simplify Docker
Entrypoint and general operations done through `Dockerfile`.
