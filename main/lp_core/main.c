/*
 * SPDX-FileCopyrightText: 2023 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include "esp_err.h"
#include "ulp_lp_core_i2c.h"
#include "ulp_lp_core_uart.h"
#include "ulp_lp_core_utils.h"
#include "ulp_lp_core_lp_timer_shared.h"

#include "bme280.h"

#define LP_I2C_TRANS_TIMEOUT_CYCLES 	5000
#define LP_SLEEP_INIT_US				100000
#define LP_SLEEP_READ_US				300000
#define LP_UART_PORT_NUM    			LP_UART_NUM_0
#define BME280_TEMP_DIFF_THRESHOLD		20

volatile uint32_t bme_initialise;
volatile uint32_t bme_temp;
volatile uint32_t bme_humid;
volatile uint32_t bme_press;

static uint32_t bme_temp_last = 0;

static s8 BME280_Init_lp_core(void);
static s8 BME280_Read_data_lp_core(void);
static s8 BME280_Set_force_mode_lp_core(void);
static s8 BME280_I2C_bus_write(u8 dev_addr, u8 reg_addr, u8 *reg_data, u8 cnt);
static s8 BME280_I2C_bus_read(u8 dev_addr, u8 reg_addr, u8 *reg_data, u8 cnt);
static void BME280_delay_msek(u32 msek);

int main(void) {

	char buf[16] = { 0 };

	if (bme_initialise) {

		bme_initialise = 0;

		if (BME280_Init_lp_core() != SUCCESS) {

			sprintf(buf, "Init error\n");
			lp_core_uart_write_bytes(LP_UART_PORT_NUM, &buf, strlen(buf), 500);

		}

		ulp_lp_core_lp_timer_set_wakeup_time(LP_SLEEP_INIT_US);
		ulp_lp_core_halt();

	} else {

		if (BME280_Read_data_lp_core() != SUCCESS) { // Prepared for future check

			sprintf(buf, "Read error\n");
			lp_core_uart_write_bytes(LP_UART_PORT_NUM, &buf, strlen(buf), 500);

		}

		if (abs(bme_temp - bme_temp_last) > BME280_TEMP_DIFF_THRESHOLD) {

			bme_temp_last = bme_temp;

			ulp_lp_core_wakeup_main_processor();

		}

		if (BME280_Set_force_mode_lp_core() != SUCCESS) {

			sprintf(buf, "Force error\n");
			lp_core_uart_write_bytes(LP_UART_PORT_NUM, &buf, strlen(buf), 500);

		}

		ulp_lp_core_lp_timer_set_wakeup_time(LP_SLEEP_READ_US);
		ulp_lp_core_halt();

	}

	return 0;
}

static s8 BME280_Init_lp_core(void) {

	s8 com_rslt;

	struct bme280_t bme280 = { .bus_write = BME280_I2C_bus_write, .bus_read =
			BME280_I2C_bus_read, .dev_addr = BME280_I2C_ADDRESS2, .delay_msec =
			BME280_delay_msek };

	com_rslt = bme280_init(&bme280);

	com_rslt += bme280_set_oversamp_pressure(BME280_OVERSAMP_16X);
	com_rslt += bme280_set_oversamp_temperature(BME280_OVERSAMP_2X);
	com_rslt += bme280_set_oversamp_humidity(BME280_OVERSAMP_1X);

	com_rslt += bme280_set_standby_durn(BME280_STANDBY_TIME_1_MS);
	com_rslt += bme280_set_filter(BME280_FILTER_COEFF_16);

	com_rslt += bme280_set_power_mode(BME280_NORMAL_MODE);

	return com_rslt;

}

static s8 BME280_Read_data_lp_core(void) {

	s8 com_rslt;

	static s32 v_uncomp_pressure_s32;
	static s32 v_uncomp_temperature_s32;
	static s32 v_uncomp_humidity_s32;

	com_rslt = bme280_read_uncomp_pressure_temperature_humidity(
			&v_uncomp_pressure_s32, &v_uncomp_temperature_s32,
			&v_uncomp_humidity_s32);

	bme_temp = bme280_compensate_temperature_int32(v_uncomp_temperature_s32);
	bme_humid = bme280_compensate_humidity_int32(v_uncomp_humidity_s32);
	bme_press = bme280_compensate_pressure_int32(v_uncomp_pressure_s32);

	return com_rslt;

}

static s8 BME280_Set_force_mode_lp_core(void) {

	s8 com_rslt;

	com_rslt += bme280_set_power_mode(BME280_FORCED_MODE);

	return com_rslt;

}

static s8 BME280_I2C_bus_write(u8 dev_addr, u8 reg_addr, u8 *reg_data, u8 cnt) {

	s32 iError = BME280_INIT_VALUE;

	esp_err_t espRc;

	u8 write_data[cnt + 1];

	write_data[0] = reg_addr;

	for (int i = 0; i < cnt; i++) {
		write_data[i + 1] = reg_data[i];
	}

	espRc = lp_core_i2c_master_write_to_device(LP_I2C_NUM_0, dev_addr,
			write_data, cnt + 1,
			LP_I2C_TRANS_TIMEOUT_CYCLES);

	if (espRc == ESP_OK) {
		iError = SUCCESS;
	} else {
		iError = ERROR;
	}

	return (s8) iError;

}

static s8 BME280_I2C_bus_read(u8 dev_addr, u8 reg_addr, u8 *reg_data, u8 cnt) {

	s32 iError = BME280_INIT_VALUE;
	esp_err_t espRc;

	espRc = lp_core_i2c_master_write_to_device(LP_I2C_NUM_0, dev_addr,
			&reg_addr, 1,
			LP_I2C_TRANS_TIMEOUT_CYCLES);

	if (espRc == ESP_OK) {
		iError = SUCCESS;
	} else {
		iError = ERROR;
	}

	espRc = lp_core_i2c_master_read_from_device(LP_I2C_NUM_0, dev_addr,
			reg_data, cnt,
			LP_I2C_TRANS_TIMEOUT_CYCLES);

	if (espRc == ESP_OK) {
		iError = SUCCESS;
	} else {
		iError = ERROR;
	}

	return (s8) iError;

}

static void BME280_delay_msek(u32 msek) {
	ulp_lp_core_delay_us(msek * 1000);
}
