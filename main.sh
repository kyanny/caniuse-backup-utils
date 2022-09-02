#!/bin/bash

curl -sLOJ 'https://docs.google.com/spreadsheets/d/1L78xOOjCm-j3r3cRj-gLFwosfoqw1d6-hmz2MPZmUsA/export?format=xlsx'
ruby main.rb
