# go image Text  

[![test](https://github.com/mskian/go-image-text/actions/workflows/test.yml/badge.svg)](https://github.com/mskian/go-image-text/actions/workflows/test.yml)  

Create Simple Quotes images with Square Size for Social Media Posts and Status.  

![go image Text](https://raw.githubusercontent.com/mskian/go-image-text/main/Images/example.png)

## Usage

- Download or clone the repo

```sh
https://github.com/mskian/go-image-text.git
cd go-image-text
```

- Execute the Script

```sh
go run create.go -h
```

- create a Quotes

```sh
go run create.go -q "Always do your best. What you plant now, you will harvest later."
```

- you can replace the font and image with yours in `Images` and `Fonts` folder
- image name must be in `quotes.png` and size `1080x1080`
- same as for Font file `fonts.ttf` (Just rename your font file)
- For Unicode support, your font must be supported Unicode texts and emojis

## Build Package

- Run Make file to build a package for your Systems
- Use this Script as CLI
- After Building the Package Just Rename the Package to `quotes`
- Give Execute Permission and Run the CLI

```sh
make build && make package-zip
```

```sh

## Create Specific Folder for Quotes CLI and store Generated Quotes

mkdir quotes
cd quotes

## Unzip the Build Package

unzip quotes-linux-amd64.zip

## Rename the file

mv quotes-linux-amd64.zip mv quotes

## Give Execute Permission

chmod +x quotes

## Create Quotes image

quotes -q "Always do your best. What you plant now, you will harvest later."

```

- Clean Build Packages

```sh
make clean
```

## API

- Go Graphics - <https://github.com/fogleman/gg>

## Packges Build for

Linux, Apple, Windows and Android - `/makefile`  

- Linux-386
- Linux-arm-7
- Linux-amd64
- Linux-arm64
- Andriod-arm64
- windows-386
- windows-amd64
- darwin-amd64
- darwin-arm64

## LICENSE

MIT
