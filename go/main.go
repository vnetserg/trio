package main

import (
    "bufio"
    "os"
    "log"
)

func writeLine(file *os.File, line string) {
    file.Write([]byte(line))
    file.Write([]byte("\n"))
}

func main() {
    args := os.Args[1:]

    first_in, err := os.Open(args[0])
    if err != nil {
        log.Fatal(err)
    }
    defer first_in.Close()

    second_in, err := os.Open(args[1])
    if err != nil {
        log.Fatal(err)
    }
    defer second_in.Close()

    first_out, err := os.Open(args[2])
    if err != nil {
        log.Fatal(err)
    }
    defer first_out.Close()

    second_out, err := os.Open(args[3])
    if err != nil {
        log.Fatal(err)
    }
    defer second_out.Close()

    common_out, err := os.Open(args[4])
    if err != nil {
        log.Fatal(err)
    }
    defer common_out.Close()

    first_lines := make(map[string]struct{})
    first_scanner := bufio.NewScanner(first_in)
    for first_scanner.Scan() {
        first_lines[first_scanner.Text()] = struct{}{}
    }

    if err := first_scanner.Err(); err != nil {
        log.Fatal(err)
    }

    common_lines := make(map[string]struct{})
    second_scanner := bufio.NewScanner(second_in)
    for second_scanner.Scan() {
        line := second_scanner.Text()
        _, ok := first_lines[line]
        if ok {
            common_lines[line] = struct{}{}
        } else {
            writeLine(second_out, line)
        }
    }

    if err := second_scanner.Err(); err != nil {
        log.Fatal(err)
    }

    for line := range common_lines {
        writeLine(common_out, line)
    }

    for line := range first_lines {
        _, ok := common_lines[line]
        if !ok {
            writeLine(first_out, line)
        }
    }
}
