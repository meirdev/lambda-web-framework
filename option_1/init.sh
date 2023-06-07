#!/bin/bash

# Install dependencies in the current directory
python -m pip install --target ./ mangum django

# Remove all info files
rm -rf *.dist-info

# Remove all cache files
find . -type f -name '*.py[co]' -delete -o -type d -name __pycache__ -delete

# Remove all locale files except for English
for locale_dirs in $(find django -name "locale" -type d); do
    for dir in $locale_dirs/*; do
        if [ -d "$dir" ] && [ "$(basename $dir)" != "en" ]; then
            rm -rf "$dir"
        fi
    done
done

zip -r9 ../option_1.zip .
