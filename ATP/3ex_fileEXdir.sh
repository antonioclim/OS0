#!/bin/bash

echo "Enter file name: "
read filename

if [ -e "$filename" ]; then
    echo "File exists."
else
    echo "File doesn't exist."
fi

