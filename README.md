1. Checkout submodules:

`git submodule update --init --recursive`

2. Build the binaries:

`make all`

3. Generate the data:

`make data`

4. Measure individual binaries:

```
./median_run.py 10 ./build/cpp data/first data/second data/first_uniq data/second_uniq data/common
./median_run.py 10 ./build/cpp_absl data/first data/second data/first_uniq data/second_uniq data/common
./median_run.py 10 ./build/rust data/first data/second data/first_uniq data/second_uniq data/common
```
