#!/bin/bash

# empty the trash and download files every day at 4

TERMINAL_NOTIFIER='/usr/local/Cellar/terminal-notifier/1.7.1/bin/terminal-notifier'

rm -rf ~/.Trash/*
rm -rf ~/Downloads/*

$TERMINAL_NOTIFIER $NOTIF_ARGS \
    -title 'Clean up' \
    -message 'Downloads and Trash folders deleted'
