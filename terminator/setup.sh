#!/bin/bash

mkdir -p ~/.config/terminator
cp config ~/.config/terminator/config

#install Monaco Font
sudo mkdir -p /usr/share/fonts/truetype/ttf-monaco && \
sudo wget https://github.com/jachermocilla/dotfiles/blob/master/terminator/Monaco_Linux.ttf -O /tmp/Monaco_Linux.ttf && \
sudo mv /tmp/Monaco_linux.ttf /usr/share/fonts/truetype/ttf-monaco/Monaco_Linux.ttf && \
sudo fc-cache
