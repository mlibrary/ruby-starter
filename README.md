# ruby-docker-boilerplate

Boilerplate code for starting a ruby project with docker / docker-compose

## Set up

Run the setup script
```
./init.sh
```

This will:

* copy `.env-example` to `.env` 
* enable the precommit hook which wil lint the code before committing.  Uncomment
  those lines in `.git/hooks/precommit` to enable running tests.
* build the docker image
* install the gems

The script does not overwrite `.env` or `/git/hooks/precommit`.

## Background
This repository goes with this documentation:
https://mlit.atlassian.net/wiki/spaces/LD/pages/2404090314/Getting+Started+with+Docker+and+Docker-Compose 
