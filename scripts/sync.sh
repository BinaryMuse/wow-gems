#!/usr/bin/env bash

rsync -vzr --delete . --exclude .git muse:/var/www/vhosts/brandontilley.com/subdomains/gems
