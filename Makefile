all: cpp cpp_jemalloc cpp_absl cpp_absl_jemalloc rust rust_jemalloc

build:
	mkdir -p build

cpp: build
	clang++ -O3 cpp/main.cpp -o build/cpp

cpp_jemalloc:
	clang++ -O3 cpp/main.cpp -ljemalloc -o build/cpp_jemalloc

cpp_absl: build
	mkdir -p cpp_absl/build
	cd cpp_absl/build && cmake .. -DCMAKE_BUILD_TYPE=RELEASE && make
	cp cpp_absl/build/cpp_absl build/cpp_absl

cpp_absl_jemalloc: build
	mkdir -p cpp_absl_jemalloc/build
	cd cpp_absl_jemalloc/build && cmake .. -DCMAKE_BUILD_TYPE=RELEASE && make
	cp cpp_absl_jemalloc/build/cpp_absl_jemalloc build/cpp_absl_jemalloc

rust:
	cd rust && cargo build --release
	cp rust/target/release/rust build/rust

rust_jemalloc:
	cd rust_jemalloc && cargo build --release
	cp rust_jemalloc/target/release/rust_jemalloc build/rust_jemalloc

generate:
	@echo "This may take several minutes..."
	mkdir data
	./generate.py data/first data/second 10000000 seed

.PHONY: cpp cpp_jemalloc cpp_absl cpp_absl_jemalloc rust rust_jemalloc generate
