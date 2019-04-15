#!/usr/bin/env bash

# refresh the source docs of the tree
rm -rf docs/source/rst
sphinx-apidoc -f -o docs/source/rst .

cd docs

# refresh the build
make clean
make html