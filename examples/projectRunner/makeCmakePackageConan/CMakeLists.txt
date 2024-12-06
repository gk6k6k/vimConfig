cmake_minimum_required(VERSION 3.0)

project(Fooo)

add_library(Fooo SHARED source/Fooo.cpp)

target_include_directories(
  Fooo PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
              $<INSTALL_INTERFACE:include>)

install(
  TARGETS Fooo
  EXPORT Fooo-targets
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
  INCLUDES
  DESTINATION include)

install(
  EXPORT Fooo-targets
  FILE "fooo-targets.cmake"
  DESTINATION lib/cmake/Fooo)

configure_file(foo-config.cmake.in "${CMAKE_BINARY_DIR}/fooo-config.cmake"
               @ONLY)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
  "${CMAKE_BINARY_DIR}/fooo-config-version.cmake"
  VERSION 1.0
  COMPATIBILITY AnyNewerVersion)

install(FILES "${CMAKE_BINARY_DIR}/fooo-config.cmake"
              "${CMAKE_BINARY_DIR}/fooo-config-version.cmake"
              DESTINATION lib/cmake/Fooo)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include/ DESTINATION include)
