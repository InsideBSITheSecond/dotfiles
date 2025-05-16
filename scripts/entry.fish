#!/bin/fish

mkdir .logs
fish scripts/install.fish 2>&1 | tee .logs/install.log