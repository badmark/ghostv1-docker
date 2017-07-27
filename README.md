# ghostv1-docker

Docker image for Ghost's latest version of Ghost blog 1.0.2


# Creating User and Database at Launch

`
To create a new database specify the database name in the `DB_NAME` variable. The following command creates a new database named *dbname*:

```bash
docker run --name mysql -d \
  -e 'DB_NAME=dbname' badmark/ghostv1-docker
```

You may also specify a comma separated list of database names in the `DB_NAME` variable. The following command creates two new databases named *dbname1* and *dbname2*

```bash
docker run --name mysql -d \
-e 'DB_NAME=dbname1,dbname2' badmark/ghostv1-docker
```

To create a new user you should specify the `DB_USER` and `DB_PASS` variables.

```bash
docker run --name mysql -d \
  -e 'DB_USER=dbuser' -e 'DB_PASS=dbpass' -e 'DB_NAME=dbname' \
  badmark/ghostv1-docker
```

The above command will create a user *dbuser* with the password *dbpass* and will also create a database named *dbname*. The *dbuser* user will have full/remote access to the database.

**NOTE**
- If the `DB_NAME` is not specified, the user will not be created
- If the user/database user already exists no changes are be made
- If `DB_PASS` is not specified, an empty password will be set for the user

By default the new database will be created with the `utf8` character set and `utf8_unicode_ci` collation. You may override these with the `MYSQL_CHARSET` and `MYSQL_COLLATION` variables.

```bash
docker run --name mysql -d \
  -e 'DB_USER=dbuser' -e 'DB_PASS=dbpass' -e 'DB_NAME=dbname' \
  -e 'MYSQL_CHARSET=utf8mb4' -e 'MYSQL_COLLATION=utf8_bin' \
  badmark/ghostv1-docker
```

# Creating remote user with privileged access

To create a remote user with privileged access, you need to specify the `DB_REMOTE_ROOT_NAME` and `DB_REMOTE_ROOT_PASS` variables, eg.

```bash
docker run --name mysql -d \
  -e 'DB_REMOTE_ROOT_NAME=root' -e 'DB_REMOTE_ROOT_PASS=secretpassword' \
  badmark/ghostv1-docker
```

Optionally you can specify the `DB_REMOTE_ROOT_HOST` variable to define the address space within which remote access should be permitted. This defaults to `172.17.0.1` and should suffice for most cases.

Situations that would require you to override the default `DB_REMOTE_ROOT_HOST` setting are:

- If you have changed the ip address of the `docker0` interface
- If you are using host networking, i.e. `--net=host`, etc.

# Shell Access

For debugging and maintenance purposes you may want access the containers shell. If you are using docker version `1.3.0` or higher you can access a running containers shell using `docker exec` command.

```bash
docker exec -it mysql bash
```
