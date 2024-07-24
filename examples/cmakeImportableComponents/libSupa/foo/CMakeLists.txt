cmake_minimum_required(VERSION 3.0)

project (SupaFoo)

add_library(SupaFoo SHARED source/Supa.cpp)
add_library(Supa::Foo ALIAS SupaFoo)

#target_include_directories(SupaFoo PUBLIC include)
target_include_directories(SupaFoo
  PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)

install(
  TARGETS SupaFoo
  EXPORT Foo-targets
  COMPONENT Foo
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  RUNTIME DESTINATION bin
  INCLUDES DESTINATION include)

install(
  EXPORT Foo-targets
  FILE "Supa-Foo-targets.cmake"
  NAMESPACE Supa::
  DESTINATION lib/cmake/Supa
  COMPONENT Foo)

configure_file(
  foo-config.cmake.in
  "${CMAKE_BINARY_DIR}/Supa-Foo-config.cmake"
  @ONLY)

include(CMakePackageConfigHelpers)

write_basic_package_version_file(
  "${CMAKE_BINARY_DIR}/Supa-Foo-config-version.cmake"
  VERSION 1.0
  COMPATIBILITY AnyNewerVersion)

install(
  FILES "${CMAKE_BINARY_DIR}/Supa-Foo-config.cmake"
        "${CMAKE_BINARY_DIR}/Supa-Foo-config-version.cmake"
  DESTINATION lib/cmake/Supa
  COMPONENT Foo
)

install(
  DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include
  COMPONENT Foo
  DESTINATION ${CMAKE_INSTALL_PREFIX}
)
