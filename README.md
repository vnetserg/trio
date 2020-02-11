1. Checkout submodules:

`git submodule update --init --recursive`

2. Build the binaries:

`make all`

3. Generate the data:

`make data`

4. Measure individual binaries:

```
for binary in $(ls build/*); do
    echo $binary
    ./median_run.py 10 $binary data/first data/second data/first_uniq data/second_uniq data/common
done
```
