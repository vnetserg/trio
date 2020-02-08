#!/usr/bin/env python3

import subprocess
import sys
import time

def get_wall_time(args):
    start = time.time()
    result = subprocess.run(args)
    wall_time = time.time() - start
    assert result.returncode == 0
    return wall_time

def main():
    assert len(sys.argv) > 2, "Too few arguments"
    count = int(sys.argv[1])

    times = []
    for _ in range(count):
        wall_time = get_wall_time(sys.argv[2:])
        print(wall_time)
        times.append(wall_time)

    print("MEDIAN: {}".format(sorted(times)[len(times) // 2]))

if __name__ == "__main__":
    main()
