{\rtf1\ansi\ansicpg1252\cocoartf1561\cocoasubrtf400
{\fonttbl\f0\fnil\fcharset0 Calibri;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs32 \cf0 \expnd0\expndtw0\kerning0
# Set initial variables.\
bookfolder=book\
set bookName=YourBookName\
\
\
pandoc file1.md file2.md file3.md > %bookName%.md\
pandoc -s -o %bookName%.html %bookName%.md\
python -m weasyprint %bookName%.html %bookName%.pdf -s %bookName%.css}