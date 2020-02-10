use std::{
    env,
    fs::{File, OpenOptions},
    io::{BufReader, BufRead, BufWriter, Write},
};

use ahash::AHashSet;

#[global_allocator]
static ALLOC: jemallocator::Jemalloc = jemallocator::Jemalloc;

fn open_file_for_read(path: &str) -> BufReader<File> {
    let file = OpenOptions::new()
        .read(true)
        .open(path)
        .unwrap();
    BufReader::new(file)
}

fn open_file_for_write(path: &str) -> BufWriter<File> {
    let file = OpenOptions::new()
        .create(true)
        .write(true)
        .truncate(true)
        .open(path)
        .unwrap();
    BufWriter::new(file)
}

fn write_line(file: &mut BufWriter<File>, line: &[u8]) {
    file.write(line).unwrap();
    file.write(b"\n").unwrap();
}

fn main() {
    let args: Vec<String> = env::args().collect();
    assert_eq!(args.len(), 6, "expected 5 arguments, got {}", args.len() - 1);

    let first_in = open_file_for_read(&args[1]);
    let second_in = open_file_for_read(&args[2]);
    let mut first_out = open_file_for_write(&args[3]);
    let mut second_out = open_file_for_write(&args[4]);
    let mut common_out = open_file_for_write(&args[5]);

    let first_lines: AHashSet<Vec<u8>> = first_in.split('\n' as u8).map(|line| line.unwrap()).collect();

    let mut common_lines = AHashSet::<Vec<u8>>::new();
    for line in second_in.split('\n' as u8).map(|line| line.unwrap()) {
        if first_lines.contains(&line) {
            common_lines.insert(line);
        } else {
            write_line(&mut second_out, &line);
        }
    }

    for line in common_lines.iter() {
        write_line(&mut common_out, &line);
    }

    for line in first_lines.iter() {
        if !common_lines.contains(line) {
            write_line(&mut first_out, &line);
        }
    }
}
