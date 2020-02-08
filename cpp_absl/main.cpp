#include <fstream>
#include <ios>
#include <iostream>
#include <cassert>

#include "absl/container/flat_hash_set.h"

void write_line(std::ofstream *stream, const std::string& line)
{
    stream->write(line.c_str(), line.size());
    stream->write("\n", 1);
}

int main(int argc, char **argv)
{
    std::ios_base::sync_with_stdio(false);
    std::cin.tie(NULL);

    assert(argc == 6);

    std::ifstream first_in(argv[1]);
    std::ifstream second_in(argv[2]);
    std::ofstream first_out(argv[3]);
    std::ofstream second_out(argv[4]);
    std::ofstream common_out(argv[5]);

    std::string line;

    absl::flat_hash_set<std::string> first_lines;
    while (std::getline(first_in, line)) {
        first_lines.insert(std::move(line));
    }

    absl::flat_hash_set<std::string> common_lines;
    while (std::getline(second_in, line)) {
        if (first_lines.find(line) != first_lines.end()) {
            common_lines.insert(std::move(line));
        } else {
            write_line(&second_out, line);
        }
    }

    for (const auto& line : common_lines) {
        write_line(&common_out, line);
    }

    for (const auto& line : first_lines) {
        if (common_lines.find(line) == common_lines.end()) {
            write_line(&first_out, line);
        }
    }
}
