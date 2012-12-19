#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

#include <unistd.h>
#include <sys/select.h>
#include <sys/time.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <cutils/properties.h>

struct baseband_info
{
    const char*	baseband;
    const char* model;
};

static const struct baseband_info baseband_table[] =
{
    // atnt V10f (tdm)
    // bell? V10j (Flyview @ xda)
    // bell  V20e (miji2 @ xda)
    { "8660-AAABQNBYA-30552040", "i_atnt" },

    // atnt V??? (drumist @ xda)
    { "8660-AAABQNBYA-34701050", "i_atnt" },

    // vzw  ZV6 (tdm)
    { "8660-AAABQNBYA-3161H", "i_vzw" },

    // vzw  ZV7 (ortrigger @ af)
    { "M8660A-AABQNSZM-3.6.2421", "i_vzw" },

    { NULL, NULL }
};

int
read_soc_props(void)
{
    int fd;
    ssize_t len;
    char buf[256];
    char model[256];
    char baseband[256];
    char* p;
    struct baseband_info* info;

    fd = open("/sys/devices/system/soc/soc0/build_id", O_RDONLY);
    if (fd < 0) {
        printf("Cannot open soc file: %s\n", strerror(errno));
        return -1;
    }
    memset(buf, 0, sizeof(buf));
    len = read(fd, buf, sizeof(buf)-1);
    if (len < 5) {
        printf("Cannot read soc file\n");
        return -1;
    }
    close(fd);

    p = strchr(buf, '\n');
    if (p) {
        *p = '\0';
    }

    strcpy(baseband, buf);

    strcpy(model, "unknown");
    for (info = baseband_table; info->baseband != NULL; ++info) {
        if (!strcmp(baseband, info->baseband)) {
            strcpy(model, info->model);
            break;
        }
    }

    printf("Baseband: %s\nModel: %s\n", baseband, model);
    property_set("install.baseband", baseband);
    property_set("install.model", model);

    return 0;
}

int
read_install_props(void)
{
    int fd;
    int rc;
    char buf[1024];
    char* nextline;
    char* key;
    char* val;

    fd = open("/sdcard/.install.prop", O_RDONLY);
    if (fd < 0) {
        return -1;
    }
    memset(buf, 0, sizeof(buf));
    rc = read(fd, buf, sizeof(buf)-1);
    close(fd);
    if (rc <= 0) {
        printf("Cannot read install props\n");
        return -1;
    }

    nextline = buf;
    while (nextline != NULL) {
        key = nextline;
        nextline = strchr(key, '\n');
        if (nextline != NULL) {
            *nextline = '\0';
            ++nextline;
        }
        val = strchr(key, '=');
        if (val != NULL) {
            *val = '\0';
            ++val;
            printf("Install prop: %s=%s\n", key, val);
            property_set(key, val);
        }
    }

    return 0;
}

int
main(int argc, char** argv)
{
    read_soc_props();
    read_install_props();
    return 0;
}
