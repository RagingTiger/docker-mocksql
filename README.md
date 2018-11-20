## About
Dockerized MySQL server (from
[official Docker image](https://hub.docker.com/r/_/mysql/)) with **"MOCK"**
data provided by *mockaroo.com*.

## Purpose
To provide a simple test SQL server with test data.

## Usage
What follows is a *very* brief tutorial for spinning up a docker container
running the tigerj/mocksql server, and connecting to it using the `mysql` cli.

### Start MockSQL Server
First we need to create the container as a daemon process. Using the `create`
subcommand of the `docker` command will allow us to do this:
```
$ docker create --name mocksql -e MYSQL_ROOT_PASSWORD=$YOUR_PASSWORD \
         tigerj/mocksql
```
It hopefully goes without saying that the *shell* enviroment variable
`$YOUR_PASSWORD` is the password you will pass to MySQL server in the
container.

Now let's run the container:
```
$ docker start mocksql
```

### Start mysql CLI
Now we can run the `mysql` cli from another container that we create from the
`tigerj/mocksql` image:
```
$ docker run --rm --link mocksql:mock rm tigerj/mocksql sh -c 'exec mysql \
         -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot \
         -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'
```
Without going into great detail, this will startup a *docker container* based
on the `tigerj/mocksql` image, and run the `mysql` command in that container,
while also connecting it to the other container running the MockSQL database
and server.
