![](https://img.shields.io/github/license/cstroe/docker-goose) ![](https://img.shields.io/github/v/tag/cstroe/docker-goose)

# docker-goose

This image allows you to run your [Goose][1] migrations from a Docker container.

Use
---

- Create a `Dockerfile` in the directory that has your `dbconf.yml`
  - TIP: Your `dbconf.yml` is a lot more useful if it uses environment variables
    that you can set when you run the migration. For example, this should work
    for any postgres installation:
    ```
    default:
        driver: postgres
        open: $DATABASE_URL
    ```

- Your `Dockerfile` should contain `FROM cstroe/docker-goose:latest`. Most won't need
  anything more.

- Build and run your new container. The Docker engine will `ADD` your `dbconf.yml` and
  migrations directory using the [ONBUILD triggers][5], then execute `goose up`. You
  can pass a command to execute something other than `up`.

Configuration
-------------

The following environment variables can be passed to the container:

* `GOOSE_ENV` - customizes the goose `-env` flag value.  Defaults to `default`.

Example
-------

Given a project with a `db` directory at the root of the project containing SQL migration scripts and the following `dbconf.yml`:

```yaml
myenv:
    driver: mysql
    open: myuser:mypass@tcp(${DB_URL})/mydb
```

And the following `Dockerfile-goose`:

```dockerfile
FROM cstroe/docker-goose:latest
```

And a `docker-compose.yml` file similar to this:

```yaml
version: "2.4"

services:
  db:
    <... your database container here ...>

  goose:
    build:
      dockerfile: ./Dockerfile-goose
      context: .
    environment:
      DATABASE_URL: db:3306
      GOOSE_ENV: myenv
    depends_on:
      db:
        condition: service_healthy
```

Then run:

```shell script
docker-compose up -d --build
```

That will start the database and run the migrations.

# Links

* [Goose][1] database migration library on BitBucket.
* Forked from [JustinTulloss/docker-goose][2].
* Inspired from [shopkeep/goose][3].
* [pressly/goose][4] - a fork of Goose with more features

[1]: https://bitbucket.org/liamstask/goose/src/master/
[2]: https://github.com/JustinTulloss/docker-goose
[3]: https://github.com/shopkeep/goose
[4]: https://github.com/pressly/goose
[5]: https://docs.docker.com/engine/reference/builder/#onbuild