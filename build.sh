#!/bin/bash

elm make --warn --output main.js
uglifyjs main.js --output main.min.js --comments --compress,warnings=false --mangle
zip choker-build.zip index.html index.css main.min.js chucknorris.jpg

