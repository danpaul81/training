package main
import (
	"fmt"
	"os"
)

func main() {
	
	fmt.Println("Hello World")    

	b, err := os.ReadFile("greeting.txt")
	if err != nil {
		fmt.Println(err)
	} else {
    	      	fmt.Println(string(b))
	}
    }
