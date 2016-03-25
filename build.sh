#!/bin/bash
pod lib lint PandaHTTP.podspec  --verbose --allow-warnings
pod package PandaHTTP.podspec --force
