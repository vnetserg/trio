#!/usr/bin/env python3

import random
import sys
import string

LINE_LENGTH = 80

def write_lines(path, lines):
    with open(path, "w") as f:
        for line in lines:
            f.write(line + "\n")

def main():
    assert len(sys.argv) == 5, "expected 4 argumets, got {}".format(len(sys.argv) - 1)

    first_file = sys.argv[1]
    second_file = sys.argv[2]
    lines_count = int(sys.argv[3])

    random.seed(sys.argv[4])

    alphabet = string.ascii_letters + string.digits
    lines = ["".join(random.choice(alphabet) for _ in range(LINE_LENGTH))
             for _ in range(lines_count)]

    common_lines = lines[:len(lines) // 3]
    first_unique_lines = lines[len(lines) // 3 : 2 * len(lines) // 3]
    second_unique_lines = lines[2 * len(lines) // 3 :]

    first_lines = common_lines + first_unique_lines
    random.shuffle(first_lines)
    second_lines = common_lines + second_unique_lines
    random.shuffle(second_lines)

    write_lines(first_file, first_lines)
    write_lines(second_file, second_lines)

if __name__ == "__main__":
    main()
