cmake_minimum_required(VERSION 3.20)
project(Planeify3D LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(Planeify3D
  src/main.cpp
  src/parser/Parser.cpp
)

target_include_directories(Planeify3D PRIVATE src)

