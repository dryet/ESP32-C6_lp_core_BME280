@echo off
cd /D C:\Users\Petr\Programming\Espressif_IDE_workspaces\ESP32-C6\BME280_lp_core_master\ESP32-C6_lp_core_BME280\build\esp-idf\esp_system || (set FAIL_LINE=2& goto :ABORT)
python C:/Espressif/frameworks/esp-idf/tools/ldgen/ldgen.py --config C:/Users/Petr/Programming/Espressif_IDE_workspaces/ESP32-C6/BME280_lp_core_master/ESP32-C6_lp_core_BME280/sdkconfig --fragments-list C:/Espressif/frameworks/esp-idf/components/riscv/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_driver_gpio/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_pm/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_mm/linker.lf;C:/Espressif/frameworks/esp-idf/components/spi_flash/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_system/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_system/app.lf;C:/Espressif/frameworks/esp-idf/components/esp_common/common.lf;C:/Espressif/frameworks/esp-idf/components/esp_common/soc.lf;C:/Espressif/frameworks/esp-idf/components/esp_rom/linker.lf;C:/Espressif/frameworks/esp-idf/components/hal/linker.lf;C:/Espressif/frameworks/esp-idf/components/log/linker.lf;C:/Espressif/frameworks/esp-idf/components/heap/linker.lf;C:/Espressif/frameworks/esp-idf/components/soc/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_hw_support/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_hw_support/dma/linker.lf;C:/Espressif/frameworks/esp-idf/components/freertos/linker_common.lf;C:/Espressif/frameworks/esp-idf/components/freertos/linker.lf;C:/Espressif/frameworks/esp-idf/components/newlib/newlib.lf;C:/Espressif/frameworks/esp-idf/components/newlib/system_libs.lf;C:/Espressif/frameworks/esp-idf/components/esp_driver_gptimer/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_ringbuf/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_driver_uart/linker.lf;C:/Espressif/frameworks/esp-idf/components/app_trace/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_event/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_driver_pcnt/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_driver_spi/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_driver_mcpwm/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_driver_ana_cmpr/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_driver_dac/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_driver_rmt/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_driver_sdm/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_driver_i2c/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_driver_ledc/linker.lf;C:/Espressif/frameworks/esp-idf/components/driver/twai/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_phy/linker.lf;C:/Espressif/frameworks/esp-idf/components/vfs/linker.lf;C:/Espressif/frameworks/esp-idf/components/lwip/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_netif/linker.lf;C:/Espressif/frameworks/esp-idf/components/wpa_supplicant/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_coex/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_wifi/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_adc/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_eth/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_gdbstub/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_psram/linker.lf;C:/Espressif/frameworks/esp-idf/components/esp_lcd/linker.lf;C:/Espressif/frameworks/esp-idf/components/espcoredump/linker.lf;C:/Espressif/frameworks/esp-idf/components/ieee802154/linker.lf;C:/Espressif/frameworks/esp-idf/components/openthread/linker.lf --input C:/Espressif/frameworks/esp-idf/components/esp_system/ld/esp32c6/sections.ld.in --output C:/Users/Petr/Programming/Espressif_IDE_workspaces/ESP32-C6/BME280_lp_core_master/ESP32-C6_lp_core_BME280/build/esp-idf/esp_system/ld/sections.ld --kconfig C:/Espressif/frameworks/esp-idf/Kconfig --env-file C:/Users/Petr/Programming/Espressif_IDE_workspaces/ESP32-C6/BME280_lp_core_master/ESP32-C6_lp_core_BME280/build/config.env --libraries-file C:/Users/Petr/Programming/Espressif_IDE_workspaces/ESP32-C6/BME280_lp_core_master/ESP32-C6_lp_core_BME280/build/ldgen_libraries --objdump C:/Espressif/tools/riscv32-esp-elf/esp-13.2.0_20230928/riscv32-esp-elf/bin/riscv32-esp-elf-objdump.exe || (set FAIL_LINE=3& goto :ABORT)
goto :EOF

:ABORT
set ERROR_CODE=%ERRORLEVEL%
echo Batch file failed at line %FAIL_LINE% with errorcode %ERRORLEVEL%
exit /b %ERROR_CODE%