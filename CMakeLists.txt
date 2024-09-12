cmake_minimum_required(VERSION 3.12)
project(project_name)

# Default to C++17
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 17)
endif()

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -march=native")
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic)
endif()

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

if(DEFINED ENV{ROS_VERSION})
  if($ENV{ROS_VERSION} EQUAL "2")
    include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/ROS2.cmake)
  elseif($ENV{ROS_VERSION} EQUAL "1")
    include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/ROS1.cmake)
  else()
    message(
      FATAL_ERROR "invalid ROS_VERSION environment variable: $ENV{ROS_VERSION}")
  endif()
else()
  message(FATAL_ERROR "ROS_VERSION environment variable is not set!")
endif()
