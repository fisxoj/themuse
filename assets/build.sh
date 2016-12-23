#!/bin/bash

elm-make elm/App.elm --output app.js && \
	 uglifyjs -cm --stats app.js --output ../static/app.js && \
	rm app.js
