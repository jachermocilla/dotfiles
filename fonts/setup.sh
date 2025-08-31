#!/bin/bash

#ibm plex mono
sudo apt install fonts-ibm-plex

#install Monaco Font
sudo mkdir -p /usr/share/fonts/truetype/ttf-monaco && \
sudo cp ./Monaco_Linux.ttf /usr/share/fonts/truetype/ttf-monaco/Monaco_Linux.ttf


sudo mkdir -p /usr/share/fonts/truetype/jetbrains && \
sudo unzip -j JetBrainsMono-2.304.zip -d /usr/share/fonts/truetype/jetbrains/ 

sudo fc-cache
