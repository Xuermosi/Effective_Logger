# Install script for directory: D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "C:/Program Files/logger")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "cryptopp_dev" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/Debug/cryptopp.lib")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/Release/cryptopp.lib")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "cryptopp_dev" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/cryptopp" TYPE FILE FILES
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/3way.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/adler32.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/adv_simd.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/aes.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/aes_armv4.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/algebra.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/algparam.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/allocate.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/arc4.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/argnames.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/aria.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/arm_simd.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/asn.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/authenc.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/base32.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/base64.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/basecode.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/blake2.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/blowfish.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/blumshub.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/camellia.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/cast.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/cbcmac.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/ccm.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/chacha.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/chachapoly.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/cham.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/channels.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/cmac.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/config.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/config_align.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/config_asm.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/config_cpu.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/config_cxx.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/config_dll.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/config_int.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/config_misc.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/config_ns.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/config_os.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/config_ver.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/cpu.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/crc.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/cryptlib.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/darn.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/default.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/des.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/dh.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/dh2.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/dll.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/dmac.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/donna.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/donna_32.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/donna_64.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/donna_sse.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/drbg.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/dsa.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/eax.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/ec2n.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/eccrypto.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/ecp.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/ecpoint.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/elgamal.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/emsa2.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/eprecomp.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/esign.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/fhmqv.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/files.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/filters.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/fips140.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/fltrimpl.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/gcm.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/gf256.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/gf2_32.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/gf2n.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/gfpcrypt.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/gost.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/gzip.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/hashfwd.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/hc128.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/hc256.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/hex.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/hight.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/hkdf.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/hmac.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/hmqv.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/hrtimer.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/ida.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/idea.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/integer.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/iterhash.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/kalyna.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/keccak.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/lea.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/lsh.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/lubyrack.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/luc.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/mars.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/md2.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/md4.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/md5.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/mdc.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/mersenne.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/misc.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/modarith.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/modes.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/modexppc.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/mqueue.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/mqv.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/naclite.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/nbtheory.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/nr.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/oaep.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/oids.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/osrng.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/ossig.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/padlkrng.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/panama.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/pch.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/pkcspad.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/poly1305.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/polynomi.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/ppc_simd.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/pssr.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/pubkey.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/pwdbased.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/queue.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/rabbit.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/rabin.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/randpool.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/rc2.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/rc5.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/rc6.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/rdrand.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/rijndael.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/ripemd.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/rng.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/rsa.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/rw.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/safer.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/salsa.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/scrypt.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/seal.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/secblock.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/secblockfwd.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/seckey.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/seed.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/serpent.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/serpentp.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/sha.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/sha1_armv4.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/sha256_armv4.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/sha3.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/sha512_armv4.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/shacal2.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/shake.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/shark.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/simeck.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/simon.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/simple.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/siphash.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/skipjack.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/sm3.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/sm4.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/smartptr.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/sosemanuk.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/speck.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/square.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/stdcpp.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/strciphr.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/tea.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/threefish.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/tiger.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/trap.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/trunhash.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/ttmac.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/tweetnacl.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/twofish.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/vmac.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/wake.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/whrlpool.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/words.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/xed25519.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/xtr.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/xtrcrypt.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/xts.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/zdeflate.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/zinflate.h"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/zlib.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "cryptopp_dev" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/cmake/cryptopp/cryptopp-static-targets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/cmake/cryptopp/cryptopp-static-targets.cmake"
         "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/CMakeFiles/Export/b2240bf58d48ab81379cb5dc4149e5db/cryptopp-static-targets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/cmake/cryptopp/cryptopp-static-targets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/cmake/cryptopp/cryptopp-static-targets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cmake/cryptopp" TYPE FILE FILES "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/CMakeFiles/Export/b2240bf58d48ab81379cb5dc4149e5db/cryptopp-static-targets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cmake/cryptopp" TYPE FILE FILES "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/CMakeFiles/Export/b2240bf58d48ab81379cb5dc4149e5db/cryptopp-static-targets-debug.cmake")
  endif()
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cmake/cryptopp" TYPE FILE FILES "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/CMakeFiles/Export/b2240bf58d48ab81379cb5dc4149e5db/cryptopp-static-targets-release.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "cryptopp_dev" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cmake/cryptopp" TYPE FILE FILES
    "D:/trainingcamp/logger/logger/third_party/cryptopp_cmake/cryptopp/cryptoppConfig.cmake"
    "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/cryptoppConfigVersion.cmake"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "cryptopp_dev" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pkgconfig" TYPE FILE FILES "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/cryptopp.pc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/Debug/cryptest.exe")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/Release/cryptest.exe")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cryptopp" TYPE DIRECTORY FILES "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/TestData")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/cryptopp" TYPE DIRECTORY FILES "D:/trainingcamp/logger/build/x64-Debug/logger/third_party/cryptopp_cmake/cryptopp/TestVectors")
endif()

