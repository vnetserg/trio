all: cpp cpp_absl rust

build:
	mkdir -p build

cpp: build
	clang++ -O3 cpp/main.cpp -o build/cpp

cpp_absl: build
	mkdir -p cpp_absl/build
	cd cpp_absl/build && cmake .. -DCMAKE_BUILD_TYPE=RELEASE && make
	cp cpp_absl/build/cpp_absl build/cpp_absl

rust:
	cd rust && cargo build --release
	cp rust/target/release/rust build/rust

generate:
	@echo "This may take several minutes..."
	mkdir data
	./generate.py data/first data/second 10000000 seed

.PHONY: cpp cpp_absl rust generate
