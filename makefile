FONT_DIR=./Fonts/
IMAGE_DIR=./Images/
BUILD_DIR=./build

clean:
	rm -rf ${BUILD_DIR}

extract-font:
	mkdir ${FONT_DIR} || true
	for FONTS in $(shell find . -type f -path '*/golang/go-image-text*/*' -name fonts.ttf); do \
		DIR=`echo $$FONTS | tr "/" _ | sed -e 's/vendor_//; s/_FONTS//'` ; \
        cp $$FONTS ${FONT_DIR}$$DIR ; \
    done

extract-image:
	mkdir ${IMAGE_DIR} || true
	for IMAGE in $(shell find . -type f -path '*/golang/go-image-text*/*' -name quotes.png); do \
		DIR=`echo $$IMAGE | tr "/" _ | sed -e 's/vendor_//; s/_IMAGE//'` ; \
        cp $$IMAGE ${IMAGE_DIR}$$DIR ; \
    done

package-zip: extract-font extract-image
	for BUILD in $(shell find ${BUILD_DIR}/*); do \
       zip -j $$BUILD.zip $$BUILD ./Fonts; \
	   zip -j $$BUILD.zip $$BUILD ./Images; \
       zip -ur $$BUILD.zip ${FONT_DIR}; \
	   zip -ur $$BUILD.zip ${IMAGE_DIR}; \
    done

build:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64       go build -o build/quotes-windows-amd64.exe create.go
	CGO_ENABLED=0 GOOS=windows GOARCH=arm64       go build -o build/quotes-windows-arm64.exe create.go
	CGO_ENABLED=0 GOOS=windows GOARCH=386         go build -o build/quotes-windows-386.exe   create.go
	CGO_ENABLED=0 GOOS=linux   GOARCH=amd64       go build -o build/quotes-linux-amd64       create.go
	CGO_ENABLED=0 GOOS=linux   GOARCH=386         go build -o build/quotes-linux-386         create.go
	CGO_ENABLED=0 GOOS=linux   GOARCH=arm64       go build -o build/quotes-linux-arm64       create.go
	CGO_ENABLED=0 GOOS=linux   GOARCH=arm GOARM=7 go build -o build/quotes-linux-arm-7       create.go
	CGO_ENABLED=0 GOOS=darwin  GOARCH=amd64       go build -o build/quotes-darwin-amd64      create.go
	CGO_ENABLED=0 GOOS=darwin  GOARCH=arm64       go build -o build/quotes-darwin-arm64      create.go
	CGO_ENABLED=0 GOOS=android GOARCH=arm64       go build -o build/quotes-android-arm64     create.go
