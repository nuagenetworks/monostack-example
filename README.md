# Monolithe Stack Example

This repository contains a ready to use example of the entire Monolithe Stack. This example contains everything you need to build a ToDo List application from the specifications, up to the client.


## Prerequisites

You need [Docker](https://docs.docker.com/engine/installation/).

Fork this repository:

    $ open https://github.com/nuagenetworks/monostack-example/fork

Clone your fork on your machine:

    $ git clone --recursive https://github.com/[your-github-username]/monostack-example.git
    $ cd monostack-example

Create a Python virtual environment:

    $ virtualenv /tmp/monostack && source /tmp/monostack/bin/activate

Install these two Python packages:

    $ pip install git+https://github.com/nuagenetworks/bambou.git
    $ pip install git+https://github.com/nuagenetworks/monolithe.git

Pull the docker following images:

    $ docker pull monolithe/garuda
    $ docker pull monolithe/specsdirector-client
    $ docker pull monolithe/specsdirector-server

Get a GitHub Token:

    $ open https://github.com/settings/tokens/new

Leave all the default values, click on `generate`. Copy the token somewhere (**you won't be able to see it again if you close the page**).


## Install and run the Monolithe Specifications Director

Get the docker-compose file for the Specifications Director:

    $ curl -o specifications-director.yml https://raw.githubusercontent.com/nuagenetworks/specifications-director/master/docker-compose.yml

Start the Specifications Director:

    $ docker-compose -f specifications-director.yml up -d

Now, you should be able access the specifications director:

    $ open https://$(docker-machine ip)

There is no authentication enabled. You can log in with any couple of login/password. The server field needs to be:

    $ echo https://$(docker-machine ip):1984
    https://192.168.99.100:1984


 Log into the Specifications Director  click on the top right gear icon, click on the `+` button, enter:
- Name: `GitHub` (or whatever you like)
- Value: `[your-github-token]`

Then click on `Create`. Then click on the back button, at the top right corner, to leave the configuration view.

Click on the `+` button to add a new repository and enter the following values:

- Name: `TDLDK` (or whatever you like)
- GitHub API URL: `https://api.github.com`
- Github Repository: `[your-github-username]` / `monostack-example` @`mater`
- Path to Specifications: `Specifications`
- Token: click on the paper clip to associate your GitHub Token

Click save and it will create the new Repository. Select it. As this is the first time, the repository will be pulled. When the job is done, you will see the representation of all the Specifications present in `https://github.com/[your-github-username]/monostack-example/tree/master/Specifications`.

## Improve the specifications with the Specification Director

The current Specifications describe a simple ToDo list. It has some users and some *Lists* at the root level. *Lists* have some *Tasks*, and *Users* can be associated to a particular *Task*.

Now we want to add a new object top level api *Locations* that will have a required `name` and an `address` as attributes. Then we want to be able to associate one (and only one) *Location* to a *List*.

### Create a Location Specification

- Select your `TDLDK` Repository.
- Click on the `+` button at the bottom of the list of Specifications to create a new specification. Enter the following:
    - ReST Name: `location`
    - Resource Name: `locations` (should be auto populated)
    - Entity Name: `Location` (should be auto populated)
    - Root API Specification: not checked (default)

Click on `Create`.

### Create a the attributes for Location

Select the newly created *Location* specification. Select the `Attributes` tab, then click the `+` button to add a new attribute. Enter the following values:

- Name: `address`
- Description: `The address of the location.`

Click `Create`. Create a second one:

- Name: `name`
- Description: `The name of the location.`

Click `Create`.

Now select the newly created `name` attribute, and on the right hand editor, scroll down to find and enable the checkbox `required`. Then click on the `Update` button at the bottom.

### Attach it to the root API

On the Specifications, select the one named `root`. Then select the tab `Children APIs`. Click the `+` button to add a new children API:

- Relationship Type: `Parent/Child relationship`
- Specification: Click on the paper clip to select the newly created `location` specification
- Operations (all default):
    - Allow Retrieval: checked
    - Allow Creation: checked
    - Allow Bulk Creation: not checked
    - Allow Bulk Modification: not checked
    - Allow Bulk Deletion: not checked

Then click the `Create` button


### Add the association key to the existing list specification

Select the existing *list* specification in the Specifications list, then go the the Attribute part. Add a new attribute:

- Name: `associatedLocationID`
- Description: `ID of the associated location.`

Then click `Update`.


### Check what you just did on GitHub

Every action you did created a commit on GitHub. This allows to have a really cool workflow as you will be able to open pull requests, and review your specifications with the rest of your team. You check that out, Click on the button `GitHub`, on the top right corner to get open the page, then look at the commit list.

We didn't do any fork, or branching here, but in a normal scenario, you should. Multiple people can work on a part of the specs, then open pull requests that will be merged into the master. You can then click on the `Synchronize` button to pull the latest changes. If you are working on a fork, the Specifications Director will also merge back the upstream's master branch right into your development branch when you click the `Synchronize` button.

Life is good!



## TodoList

Now let's put all of this on the side for now. The monostack-example repository already contains the code for the client and the server that are implementing the ToDoList application. Let's pull our latest changed in the API

    $ docker pull

Now you should see a `location.spec` in the Specification folder.


### Server

The backend is a Garuda based library. Garuda is an application server that will provide for basically everything you need to run your applications based on Monolithe Specifications. You normally just need to write your custom business logic. Everything else is automatic. It relies on some Monolithe SDK. Here we'll generate a sdk based the todo list specifications and inject it into out server.

Generate the Python SDK:

    $ monogen --folder Specifications --language python

The generated code will be available in `codegen/python`.

Create an egg from the generated code:

    $ cd codegen/python && python setup.py sdist && cd -

Then copy the package where our Dockerfile expects it to be:

    $ cp codegen/python/dist/tdldk-1.0.tar.gz Server

Finally let's build and start the ToDoList server:

    $ cd Server && docker-compose up -d && cd -

Your server is now up and running. As we want to ensure that everything is working correctly, we'll use the cli provided by the generated sdk. So let's install our generated python package on our local machine:

    $ pip install --upgrade server/tdldk-1.0.tar.gz

Then the `tdl` command will be available. You can check the objects it manages by simply doing:

    $ tdl objects

You can give the `tdl` several arguments to pass your credentials and api url. You can also use environment variables which makes it easier. Take a look at the `Tools/rc` file. It exports some variables so we don't have to pass them manually. To use this, run:

    $ source Tools/rc

We can now create a list:

    $ tdl create list -p name="My First List" description="Very cool list indeed"

Or a location:

    $ tdl create location -p name="Nuage Networks" address="380 N Bernardo Ave, Mountain View, CA 94043"



### Client

> You will need Xcode to work on the UI.

Let's see about the client. You will need Cappuccino to be installed in order to have this to work. To install it:

    $ export CAPP_BUILD="/tmp/cappbuild"
    $ cd Client && ./buildApp --cappuccino --cappinstalldir=/tmp/narwhal
    $ export PATH="/tmp/narwhal/bin:$PATH"

Let's build the rest of the libraries.

    $ git submodule update --init # just in case you missed the --recursive during clone :)
    $ ./buildApp -L

Now, let's generate the Model source code with Monolithe and put it where it should be:

    $ cd ..
    $ monogen -f Specifications --language objj
    $ cp -a codegen/objj/* Client/Models
    $ cd Client

Open a new Terminal window to serve the local directory:

    $ python -m SimpleHTTPServer

Then access the UI:

    open http:/127.0.0.1:8000

You can log in using any credentials, and the server address should be:

    $ echo https://$(docker-machine ip):3000
    https://192.168.99.100:3000


To be continued...
