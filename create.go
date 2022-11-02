package main

import (
	"crypto/rand"
	"fmt"
	"time"
	"unsafe"

	"github.com/alexflint/go-arg"
	"github.com/briandowns/spinner"
	"github.com/fatih/color"
	"github.com/fogleman/gg"
)

var alphabet = []byte("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

func generate(size int) string {
	b := make([]byte, size)
	rand.Read(b)
	for i := 0; i < size; i++ {
		b[i] = alphabet[b[i]%byte(len(alphabet))]
	}
	return *(*string)(unsafe.Pointer(&b))
}

func main() {
	s := spinner.New(spinner.CharSets[7], 50*time.Millisecond)
	s.Prefix = "Generating Quotes image "
	s.Color("green", "bold")
	var args struct {
		Quotes string `arg:"-q,--quotes" help:"Generate a Quotes image with Text."`
	}
	arg.MustParse(&args)
	if args.Quotes != "" {
		s.Start()
		time.Sleep(1 * time.Second)
		s.Stop()
		const S = 1080
		const P = 16
		TEXT := args.Quotes
		im, err := gg.LoadImage("Images/quotes.png")
		fileData := generate(16) + ".png"
		if err != nil {
			fmt.Println("Errored in Loading image File")
			return
		}

		dc := gg.NewContext(S, S)
		dc.SetRGB(1, 1, 1)
		dc.Clear()
		dc.SetRGB(0, 0, 0)
		if err := dc.LoadFontFace("Fonts/font.ttf", 37); err != nil {
			fmt.Println("Errored in Loading Font File")
			return
		}
		dc.DrawRoundedRectangle(0, 0, 1080, 1080, 0)
		dc.DrawImage(im, 0, 0)
		dc.DrawStringWrapped(TEXT, S/2-P, S/2-P, 0.5, 0.5, S/1.4, 2.2, gg.AlignCenter)
		fmt.Printf(color.YellowString("Quotes image Created : %v\n", fileData))
		dc.Clip()
		dc.SavePNG(fileData)
	} else {
		fmt.Printf(color.MagentaString("Please Enter a Valid Option to Generate Quotes image \n"))
	}
}
