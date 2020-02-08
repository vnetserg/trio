1. Build the binaries:

`make all`

2. Generate the data:

`make data`

3. Measure individual binaries:

```
./median_run.py 10 ./build/cpp data/first data/second data/first_uniq data/second_uniq data/common
./median_run.py 10 ./build/cpp_absl data/first data/second data/first_uniq data/second_uniq data/common
./median_run.py 10 ./build/rust data/first data/second data/first_uniq data/second_uniq data/common
```
