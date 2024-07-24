cmake_minimum_required(VERSION 3.0)

project(Supa)

add_subdirectory(foo)

configure_file(
  Supa-config.cmake
  "${CMAKE_BINARY_DIR}/Supa-config.cmake"
  @ONLY)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${CMAKE_BINARY_DIR}/Supa-config-version.cmake"
  VERSION 1.0
  COMPATIBILITY AnyNewerVersion)

install(
  FILES "${CMAKE_BINARY_DIR}/Supa-config.cmake"
  DESTINATION lib/cmake/Supa
)

set(CPACK_OUTPUT_FILE_PREFIX "")
set(CPACK_GENERATOR "ZIP")
include(CPack)
