# PechaKucha

This script puts Deckset in [PechaKucha](https://en.wikipedia.org/wiki/PechaKucha) mode,
i.e. it will show every slide for 20 seconds (or the specified interval), and then it
automatically advances to the next slide.


## Installation

1. Copy _pecha-kucha.sh_ from this folder to a directory in your `$PATH`.  
   `mv pecha-kucha.sh /usr/local/bin/pecha-kucha`
2. Make the script executable  
   `chmod +x /usr/local/bin/pecha-kucha`


## Usage

### Default 20 seconds interval

Open the presentation in Deckset and play it. Then:

```shell
$ pecha-kucha
```


### Custom interval

```shell
$ pecha-kucha -i 23
```


### Note

When the script starts it immediately advances to the second slide because the assumption is 
that the first slide is just a title slide. If you want to change that behaviour simply put
the  `delay $INTERVAL` line before the `tell document 1` line.


### Author

[@chriseidhof](https://github.com/chriseidhof)
