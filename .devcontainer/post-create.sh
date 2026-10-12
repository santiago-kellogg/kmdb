#!/bin/bash
set -e

# sqlite3 is the command-line client bin/load uses. The Ruby image already
# carries the library the app itself uses.
apt-get update -qq
apt-get install -y -qq sqlite3 > /dev/null

bundle install

# An empty database to start from; bin/load rebuilds it from schema/ and data/.
bin/load
