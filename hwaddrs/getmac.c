/*
 * Copyright (C) 2011-2012 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <cutils/properties.h>

#define BT_ADDR_FILE "/data/misc/bd_addr"
#define WIFI_ADDR_FILE "/data/misc/wifi/config"

extern void oncrpc_init();
extern void oncrpc_task_start();
extern void nv_cmd_remote(int, int, void*);

static int set_bt_mac(void)
{
	struct stat st;
	FILE *fd;
	char mac[PROPERTY_VALUE_MAX];

	if (stat(BT_ADDR_FILE, &st) == 0)
	        return 0;

	property_get("service.brcm.bt.mac",mac,"010203040506");
	fd = fopen(BT_ADDR_FILE, "w");
	fprintf(fd, "%c%c:%c%c:%c%c:%c%c:%c%c:%c%c\n",
	        mac[0], mac[1], mac[2], mac[3], mac[4], mac[5],
	        mac[6], mac[7], mac[8], mac[9], mac[10], mac[11]);
	fclose(fd);

	return 0;
}

/*
 * Get the wlan MAC from nv. This attempts to replicate the
 * wifi_read_mac_address function from the stock software
 */
static int set_wifi_mac(void)
{
	struct stat st;
	FILE *fd;
	unsigned char mac[8];

	if (stat(WIFI_ADDR_FILE, &st) == 0)
	        return 0;

	memset(mac, 0, sizeof(mac)*sizeof(unsigned char));
	oncrpc_init();
	oncrpc_task_start();
	nv_cmd_remote(0, 0x1246, &mac);

	if (mac[0] == 0 && mac[1] == 0)
		return -1;

	fd = fopen(WIFI_ADDR_FILE, "w");
	fprintf(fd,"cur_etheraddr=%02x:%02x:%02x:%02x:%02x:%02x\n",
		mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
	fclose(fd);

	return 0;
}

/* Read properties and set MAC addresses accordingly */
int main() {
        set_bt_mac();
        set_wifi_mac();
	return 0;
}
