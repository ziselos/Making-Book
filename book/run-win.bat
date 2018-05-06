# Set initial variables.
bookfolder=book
set bookName=Zisis


pandoc file1.md file2.md file3.md > %bookName%.md
pandoc -s -o %bookName%.html %bookName%.md
python -m weasyprint %bookName%.html %bookName%.pdf -s %bookName%.css
PAUSE