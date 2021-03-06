#!/bin/bash

# Find all files matching pattern and extract a substring
# between start and stop character(s).

HOMEDIR="/Users/jra025/Documents/Work/Projects/aDNAPROX/Illumina_Rawdata/test"
cd $HOMEDIR
file_pattern="*"
start_string="\-"
stop_string="_"
raw_data="Raw"

if [ $# -eq 0 ]
then
    echo "Error: Valid parameter: stage_branch normal|test"
    exit 1
fi

if [ "$1" = "test" ]
  then
    echo "Running in test mode"
    filenames="$(cat tests/filenames.txt)"
    for eachfile in $filenames
      do
        dirname=$(echo "$eachfile" | grep -E -o "$start_string.*?$stop_string")

        if [ "$dirname" ]
        then
          dirname=${dirname#"-"}
          dirname=${dirname%"_"}
          echo "Creating directory: $dirname"
          echo "Moving $eachfile to: $HOMEDIR/$dirname/$raw_data"
        fi
      done
elif [ "$1" = "normal" ]
  then
    filenames=$(find . -type f -maxdepth 1 -name "$file_pattern" | sort | uniq)
    for eachfile in $filenames
      do
        dirname=$(echo "$eachfile" | grep -E -o "$start_string.*?$stop_string")

        if [ "$dirname" ]
        then
          dirname=${dirname#"-"}
          dirname=${dirname%"_"}
          echo "$dirname"
          mkdir -v "$dirname"
          mkdir -v "$dirname/$raw_data"
          mv -v "$eachfile" "$dirname/$raw_data"
        fi
      done
fi
