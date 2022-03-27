```sh
docker build . --build-arg SCOPE=api --build-arg COMMAND=start -t turborepo-api
```

```sh
docker run -t -i -p 3000:3000 turborepo-api
```