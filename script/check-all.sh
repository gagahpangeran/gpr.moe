#!/bin/bash

bin/rubocop &&\
npm run lint &&\
bin/rails test &&\
bin/brakeman &&\
bin/importmap audit
