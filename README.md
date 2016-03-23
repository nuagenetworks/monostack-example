# Monolithe Stack Example

This repository contains a ready to use example of the entire Garuda Stack. This example contains everything you need to build a ToDo List application from the specifications, up to the client.

## Prerequisites

You need docker for this to work smoothly. This is not mandatory, but it will make life easier. If you don't know Docker, then it's time to jump on the train, because it's really awesome.

This example assumes you are using Docker Machine, with the `default` VM. Everything you need to get started is available [here](https://docs.docker.com/engine/installation/).

Then you need you need the `monolithe/garuda` image:

    $ docker pull monolithe/garuda

Finally, install `bambou` and `monolithe`:

    $ pip install git+https://github.com/nuagenetworks/bambou.git
    $ pip install git+https://github.com/nuagenetworks/monolithe.git


## Build the SDK out of the Specifications

In this repository you will find a folder named `Specifications`. It contains a Monolithe Specification Set that desribes the ToDo List. In a nutshell, it describes:

 - the root api that has lists and users as children
 - the users
 - the lists that has tasks as children
 - the users can be associated to some tasks

You need to generate the Python SDK by running:

    $ monogen --folder Specifications --language python

The generated code will be available in `codegen/python`.

Create a Python package:

    $ cd codegen/python
    $ python setup.py sdist
    $ cd -

Then install it:

    pip install codegen/python/dist/tdldk-1.0.tar.gz

> Note: the generated sdk serves both for client and server operations. By installing it on your machine, you will be able to use it to build some scripts, and it will also provide a cli wich will come very handy.

You can try it out by ensuring that the cli is correctly installed:

    $ tdl objects
    [Success] 3 objects found.
    +--------+
    | Name   |
    |--------|
    | lists  |
    | tasks  |
    | users  |
    +--------+

As you can see, the cli did a bit of introspection, and found that the described api contains lists, tasks and users. We'll come back to this later.


## Server

Now we need a server to be able to serve this api. The server will be built on the top of the standard docker garuda image that you just pulled a few minutes ago.

If you take look into the `Server` directory you will find several files. Please take the time to read them. They're all commented. Then come back here when you're done to see which one you should read next.

 - `server`: the actual server code you need to write in order to get everything ready.
 - `Dockerfile`: the file to build our container image.
 - `docker-compose.yml`: the file that tells how to assemble the needed mongodb, redis and all.

Now that you are familliar with this, let's build the container image.

First, let's copy the `tdldk-1.0.tar.gz` where our `Dockerfile` expects it to be:

    $ cp codegen/python/dist/tdldk-1.0.tar.gz Server/

Then let's build the image:

    $ cd Server
    $ docker build -t tdlserver .

It should be available in you local images:

    $ docker images
    REPOSITORY    TAG     IMAGE ID       CREATED         SIZE
    tdlserver     latest  a4ae5b7d3858   2 minutes ago   697.8 MB


We just need to start it using docker-compose (ensure you are in the `Server` folder):

    $ docker-compose up -d
    Creating redis
    Creating mongo
    Creating server_tdlserver_1

And you should see them up and running:

    $ docker-compose ps
    Name                    Command             State           Ports
    ---------------------------------------------------------------------------------
    mongo                /entrypoint.sh mongod         Up      27017/tcp
    redis                /entrypoint.sh redis-server   Up      6379/tcp
    server_tdlserver_1   /bin/sh -c ./server           Up      0.0.0.0:3000->3000/tcp


 Wanna try? Then you can use the `tdl` cli:

    $ cd ../Tools
    $ source rc # this contains default connection informations to avoid having to type a lot of parameters
    $ tdl list lists
    [Success] 0 lists have been retrieved

Bingo, Let's create one:

    $ tdl create list -p name="my first list" description="very cool indeed"
    [Success] list has been created with ID=56f1ee6d7052d6001016b7fc
    +-----------------+--------------------------+
    | description     | very cool indeed         |
    | parentType      |                          |
    | lastUpdatedDate | 1458695789.97            |
    | parentID        |                          |
    | owner           | root                     |
    | creationDate    | 1458695789.97            |
    | ID              | 56f1ee6d7052d6001016b7fc |
    | name            | my first list            |
    +-----------------+--------------------------+

You have a ready to use Todo List Server. Notice how it needs virtually no code?
