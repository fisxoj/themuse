#!/bin/bash

inotifywait -q -m -e close_write,moved_to,create elm/* |
    while read -r filename event; do
        elm-make elm/App.elm --output ../static/app.js
    done

