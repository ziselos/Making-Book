#!/bin/bash 
cd -- "$(dirname "$0")"
# That tells the system to use a Bourne shell interpreter,
# and then tells OSX to run this script from the current directory.

# Set initial variables.
bookfolder="book"
bookName="Zisis"


pandoc *.md > $bookName.md 
pandoc -s -o $bookName.html $bookName.md
weasyprint $bookName.html pdf/$bookName.pdf -s style/$bookName.css
