include(Compiler/Clang)
__compiler_clang(CXX)

if(NOT "x${CMAKE_CXX_SIMULATE_ID}" STREQUAL "xMSVC")
  set(CMAKE_CXX_COMPILE_OPTIONS_VISIBILITY_INLINES_HIDDEN "-fvisibility-inlines-hidden")
endif()

cmake_policy(GET CMP0025 appleClangPolicy)
if(WIN32 OR (APPLE AND NOT appleClangPolicy STREQUAL NEW))
  return()
endif()

if(NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 2.1)
  set(CMAKE_CXX98_STANDARD_COMPILE_OPTION "-std=c++98")
  set(CMAKE_CXX98_EXTENSION_COMPILE_OPTION "-std=gnu++98")
endif()

if(NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 3.1)
  set(CMAKE_CXX11_STANDARD_COMPILE_OPTION "-std=c++11")
  set(CMAKE_CXX11_EXTENSION_COMPILE_OPTION "-std=gnu++11")
elseif(NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 2.1)
  set(CMAKE_CXX11_STANDARD_COMPILE_OPTION "-std=c++0x")
  set(CMAKE_CXX11_EXTENSION_COMPILE_OPTION "-std=gnu++0x")
endif()

if(NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 3.5)
  set(CMAKE_CXX14_STANDARD_COMPILE_OPTION "-std=c++14")
  set(CMAKE_CXX14_EXTENSION_COMPILE_OPTION "-std=gnu++14")
elseif(NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 3.4)
  set(CMAKE_CXX14_STANDARD_COMPILE_OPTION "-std=c++1y")
  set(CMAKE_CXX14_EXTENSION_COMPILE_OPTION "-std=gnu++1y")
endif()

set(CMAKE_CXX_STANDARD_DEFAULT 98)

macro(cmake_record_cxx_compile_features)
  macro(_get_clang_features std_version list)
    record_compiler_features(CXX "${std_version}" ${list})
  endmacro()

  set(_result 0)
  if (UNIX AND NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 3.4)
    _get_clang_features(${CMAKE_CXX14_STANDARD_COMPILE_OPTION} CMAKE_CXX14_COMPILE_FEATURES)
    if (_result EQUAL 0)
      _get_clang_features(${CMAKE_CXX11_STANDARD_COMPILE_OPTION} CMAKE_CXX11_COMPILE_FEATURES)
    endif()
    if (_result EQUAL 0)
      _get_clang_features(${CMAKE_CXX98_STANDARD_COMPILE_OPTION} CMAKE_CXX98_COMPILE_FEATURES)
    endif()
  endif()
endmacro()
