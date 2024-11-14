# CMake generated Testfile for 
# Source directory: D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp
# Build directory: D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
if(CTEST_CONFIGURATION_TYPE MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
  add_test([=[cryptopp-build_cryptest]=] "C:/Program Files/CMake/bin/cmake.exe" "--build" "D:/trainingcamp/logger/build/x64-Debug" "--target" "cryptest" "--config" "Debug")
  set_tests_properties([=[cryptopp-build_cryptest]=] PROPERTIES  FIXTURES_SETUP "cryptest-build" LABELS "cryptopp;cryptopp-cryptest" _BACKTRACE_TRIPLES "D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp/CMakeLists.txt;1465;add_test;D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
  add_test([=[cryptopp-build_cryptest]=] "C:/Program Files/CMake/bin/cmake.exe" "--build" "D:/trainingcamp/logger/build/x64-Debug" "--target" "cryptest" "--config" "Debug")
  set_tests_properties([=[cryptopp-build_cryptest]=] PROPERTIES  FIXTURES_SETUP "cryptest-build" LABELS "cryptopp;cryptopp-cryptest" _BACKTRACE_TRIPLES "D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp/CMakeLists.txt;1465;add_test;D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp/CMakeLists.txt;0;")
else()
  add_test([=[cryptopp-build_cryptest]=] NOT_AVAILABLE)
endif()
if(CTEST_CONFIGURATION_TYPE MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
  add_test([=[cryptopp-cryptest]=] "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/Debug/cryptest.exe" "v")
  set_tests_properties([=[cryptopp-cryptest]=] PROPERTIES  FIXTURES_REQUIRED "cryptest-build" LABELS "cryptopp;cryptopp-cryptest" WORKING_DIRECTORY "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp" _BACKTRACE_TRIPLES "D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp/CMakeLists.txt;1478;add_test;D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
  add_test([=[cryptopp-cryptest]=] "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/Release/cryptest.exe" "v")
  set_tests_properties([=[cryptopp-cryptest]=] PROPERTIES  FIXTURES_REQUIRED "cryptest-build" LABELS "cryptopp;cryptopp-cryptest" WORKING_DIRECTORY "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp" _BACKTRACE_TRIPLES "D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp/CMakeLists.txt;1478;add_test;D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp/CMakeLists.txt;0;")
else()
  add_test([=[cryptopp-cryptest]=] NOT_AVAILABLE)
endif()
if(CTEST_CONFIGURATION_TYPE MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
  add_test([=[cryptopp-cryptest-extensive]=] "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/Debug/cryptest.exe" "tv" "all")
  set_tests_properties([=[cryptopp-cryptest-extensive]=] PROPERTIES  FIXTURES_CLEANUP "cryptest-build" LABELS "cryptopp;cryptopp-cryptest" WORKING_DIRECTORY "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp" _BACKTRACE_TRIPLES "D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp/CMakeLists.txt;1490;add_test;D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
  add_test([=[cryptopp-cryptest-extensive]=] "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/Release/cryptest.exe" "tv" "all")
  set_tests_properties([=[cryptopp-cryptest-extensive]=] PROPERTIES  FIXTURES_CLEANUP "cryptest-build" LABELS "cryptopp;cryptopp-cryptest" WORKING_DIRECTORY "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp" _BACKTRACE_TRIPLES "D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp/CMakeLists.txt;1490;add_test;D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp/CMakeLists.txt;0;")
else()
  add_test([=[cryptopp-cryptest-extensive]=] NOT_AVAILABLE)
endif()
