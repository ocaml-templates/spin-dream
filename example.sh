#!/bin/bash

set -xe

rm -rf example
SPIN_CREATE_SWITCH=false SPIN_PROJECT_NAME=Demo spin new . example -d