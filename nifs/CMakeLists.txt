cmake_minimum_required(VERSION 3.0.2)
project(nifs)

# Find erl_nif.h
file(GLOB_RECURSE erlang_header_path /usr/*/erl_nif.h)
list(GET erlang_header_path 0 erlang_header_path)
get_filename_component(erlang_header_path ${erlang_header_path} DIRECTORY)
message("erl_nif.h: ${erlang_header_path}")

include_directories(${erlang_header_path})
set(CMAKE_C_FLAGS "-undefined dynamic_lookup")
add_library(fast_compare SHARED src/fast_compare.c)
