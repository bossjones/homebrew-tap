#!/usr/bin/env bash
set -e

ffprobe -i fixtures/batman.mp4 | grep "Twitter-vork muxer"
