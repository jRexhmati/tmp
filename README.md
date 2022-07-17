# API Monorepo for Booston.io - V2

## Project Structure

This is the booston.io - V2 API stack that is split up in different microservices.

In order to facilitate development and deployment a `monorepo` arhitecture was adopted in order to share some common configuration thruu out the team and orchestration.

Below it's an example of the project structure.

Each microservice lives in it's encapsulated folder and it's dependencies are / microservice, meaning that each microservice has it's own package.json

```
apps
..|
..|_auth
..|....package.json
..|_recruitment
..|....package.json
..|_settings
..|....package.jsons
```

## Tech Stack

**Here are some common libraries used throughout the services**

1. koa
2. koa-parser
3. prisma
4. typescript
5. nvm - node version manager. Install guide: [for Windows](https://content.breatheco.de/en/how-to/nvm-install-windows), [for Unix](https://www.linode.com/docs/guides/how-to-install-use-node-version-manager-nvm/)
6. apidoc - used to generate API documentation

## Ports and Services

Since we have multiple services in this estate it would be beneficial to keep track of the ports

With that in mind below is a list of port `classes` and the services that use it 

Ports starting with `70XX` are usually microservices ports:
```
  - 7070 - is reserved for `booston-centralized`
  - 7071 - auth service
  - 7072 - recruitment service
  - 7073 - settings service
  - 7074 - content service
  - 7075 - workers serice - the interface with the outside world - not the actual workers
```

Ports starting with `80XX` are usually for workers:
```
  - 8080 - main worker listenere that will watch for items in the queue and it will disaptch child procesesses
```

Ports sttarting with `95XX` are usually for debuging in node, `node-inspect`:
```
  - 9501 - auth service
  - 9502 - recruitment service
  - 9503 - settings service
  - 9504 - content service
  - 9505 - worker service - the outside interface of the workers
```


## Getting Started

**Below are the steps you need to follow in order to get started**

1. Download V1 and start the docker instance, make sure that instance is up and running thruout the dev cicle, it's the data entry point
2. `nvm use` - make sure you are using the right node version
3. `yarn generate:envs` - this will generate each apps env file and install node_modules for each project
4. make sure to edit the `.env` files, with the required information
5. `yarn clean:apps` - this will install libraries on your computer for phpstorm indexation
6. For each app or the one you're working, update the .env file with the right info
7. `yarn start:apps` - to start all  apps or `yarn start:[app_name]` to start a specific app, e.g.: `yarn start:auth`

## Working with Booston-common
`booston-common` is a set of libraries that are desinged to ease some of te development and common logic shared between the apps.
In order to make work with a local `booston-common` version you will need to clone that repo, the next steps to follow are described in the `booston-common` readme file.
To link `booston-common` (for e.g.) use `yarn link-package booston-common` - it will link to all `apps`


## BugSnag and source maps

At the time of writing there is no automated way to deploy the source map files to bugsnag in order to pinpoint the error to it's actual location.
Since we don't have an automated way (yet) you can follow this guide: https://docs.bugsnag.com/build-integrations/js/source-maps-node/
Basically it will boild down to running the following (this is just an example):
We will integrate this at some point within an automated process in order for this step to be skipped.

```
bugsnag-source-maps upload-node \
  --api-key YOUR_API_KEY_HERE \
  --app-version 1.2.3 \
  --directory apps/auth/dist
```
