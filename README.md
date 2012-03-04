# Taliesin [![Build Status](https://secure.travis-ci.org/athieriot/taliesin.png?branch=master)](http://travis-ci.org/athieriot/taliesin)

Taliesin is a simple tool to help launching build and deploy on Continuous Integration systems

## Usage

./tal.coffee --help

Usage: tal.coffee [options] [command]

Commands:

build [id]
launch builds on your Continuous Integration server

Options:

-h, --help             output usage information
-V, --version          output the version number
-b, --branch [master]  branch to work with
-v, --verbose          display debug informations

## Compatibility

### Teamcity

To make Taliesin work with teamcity, you need to configure your credentials.

The default configuration file is ~/.taliesin.properties

- hostname. Will be the url to your Teamcity server
- username
- password

Also, if you want to use the "-b branch" feature, you will need to made server side modifications.

But it's pretty simple: Your VCS source can accept an environnement variable as a branch name.
Call it env.BRANCH and set a default value for your target project.
