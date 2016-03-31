#!/bin/bash

elm make --output main.js
zip choker-build.zip index.html index.css main.js chucknorris.jpg

