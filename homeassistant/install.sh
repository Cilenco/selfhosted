#!/bin/bash

(envsubst < templates/docker-compose.yml) > docker-compose.yml
