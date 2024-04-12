#!/bin/bash

# cd to project root
cd "$(dirname "$0")/../" || exit

: "${2?"Usage: $0 Scene Row"}"

tuist scaffold row --name "$2" --scene "$1"
