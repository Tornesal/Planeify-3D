cmake_minimum_required(VERSION 3.20)
project(Planeify3D LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(planeify3d_candidates
  src/main.cpp
  src/parser/GCodeParser.cpp
  src/identify/CandidateFinder.cpp
)

target_include_directories(planeify3d_candidates PRIVATE src)

