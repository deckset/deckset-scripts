# Markdown to PDF

This script allows you to convert Deckset presentations to PDF files
from the command line.


## Installation

1. Copy _markdown-to-pdf.sh_ from this folder to a directory in your `$PATH`.  
   `mv markdown-to-pdf.sh /usr/local/bin/markdown-to-pdf`
2. Make the script executable  
   `chmod +x /path/to/markdown-to-pdf`


## Usage

### Convert a single file

```shell
$ markdown-to-pdf /path/to/file.md
```

The PDF file will be placed right next to the source file, e.g. _/path/to/file.pdf_.


### Convert multiple files

```shell
$ markdown-to-pdf /path/to/file-one.md /path/to/file-two.md /path/to/file-three.md
```


### Author

Original script by [@infinitesteps](https://github.com/infinitesteps)
