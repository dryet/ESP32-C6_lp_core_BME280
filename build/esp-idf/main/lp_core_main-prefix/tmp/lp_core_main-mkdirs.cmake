# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "C:/Espressif/frameworks/esp-idf/components/ulp/cmake"
  "C:/Users/Petr/Programming/Espressif_IDE_workspaces/ESP32-C6/BME280_lp_core_master/ESP32-C6_lp_core_BME280/build/esp-idf/main/lp_core_main"
  "C:/Users/Petr/Programming/Espressif_IDE_workspaces/ESP32-C6/BME280_lp_core_master/ESP32-C6_lp_core_BME280/build/esp-idf/main/lp_core_main-prefix"
  "C:/Users/Petr/Programming/Espressif_IDE_workspaces/ESP32-C6/BME280_lp_core_master/ESP32-C6_lp_core_BME280/build/esp-idf/main/lp_core_main-prefix/tmp"
  "C:/Users/Petr/Programming/Espressif_IDE_workspaces/ESP32-C6/BME280_lp_core_master/ESP32-C6_lp_core_BME280/build/esp-idf/main/lp_core_main-prefix/src/lp_core_main-stamp"
  "C:/Users/Petr/Programming/Espressif_IDE_workspaces/ESP32-C6/BME280_lp_core_master/ESP32-C6_lp_core_BME280/build/esp-idf/main/lp_core_main-prefix/src"
  "C:/Users/Petr/Programming/Espressif_IDE_workspaces/ESP32-C6/BME280_lp_core_master/ESP32-C6_lp_core_BME280/build/esp-idf/main/lp_core_main-prefix/src/lp_core_main-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "C:/Users/Petr/Programming/Espressif_IDE_workspaces/ESP32-C6/BME280_lp_core_master/ESP32-C6_lp_core_BME280/build/esp-idf/main/lp_core_main-prefix/src/lp_core_main-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "C:/Users/Petr/Programming/Espressif_IDE_workspaces/ESP32-C6/BME280_lp_core_master/ESP32-C6_lp_core_BME280/build/esp-idf/main/lp_core_main-prefix/src/lp_core_main-stamp${cfgdir}") # cfgdir has leading slash
endif()
