This image allows you to run your Goose migrations

Use
---

- Create a Dockerfile in the directory that has your dbconf.yml
  - TIP: Your dbconf.yml is a lot more useful if it uses environment variables
    that you can set when you run the migration. For example, this should work
    for any postgres installation.
```
default:
    driver: postgres
    open: $DATABASE_URL
```

- Your Dockerfile should contain `FROM jmtulloss/goose`. Most won't need
  anythin more.
- Build and run your new container. It will suck up your dbconf.yml and
  migrations folder in `ONBUILD` triggers, then execute `goose up`. You
  can pass a command to execute something other than `up`.

### Inspiration

This is heavily inspired/copied from https://github.com/shopkeep/goose
