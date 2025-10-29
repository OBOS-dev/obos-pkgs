#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdint.h>
#include <string.h>
#include <sys/stat.h>

enum {
    DISK_SWAP_MAGIC = 0xAD537B31,
};

enum {
    // TODO: Support.
    DISK_SWAP_FLAGS_HIBERNATE = 1 << (0),
};

// In little-endian

#define DISK_SWAP_VERSION (1U)
typedef struct disk_swap_header
{
    uint32_t magic;
    uint32_t flags;
    uint64_t reserved_block_count; // block count - reserved block count = possible block count
    uint32_t version;
    char pad[]; // padding bytes = block_size - sizeof(disk_swap_header)
} __attribute__((packed)) disk_swap_header;

void make_disk_swap(int fd, uint64_t offset, uint64_t sizelimit, uint64_t sectorsize, uint64_t pagesize, uint64_t endianness)
{
    size_t blockCount = sizelimit/sectorsize;
    struct disk_swap_header hdr = {};
    if (endianness == __BYTE_ORDER__)
        hdr.reserved_block_count = pagesize/sectorsize;
    else
        hdr.reserved_block_count = __builtin_bswap64(pagesize/sectorsize);
    if (hdr.reserved_block_count >= blockCount)
    {
        errno = ENOSPC; // No space for anything but metadata
        return;
    }
    if (endianness == __BYTE_ORDER__)
    hdr.magic = DISK_SWAP_MAGIC;
    else
        hdr.magic = __builtin_bswap32(DISK_SWAP_MAGIC);
    if (endianness == __BYTE_ORDER__)
        hdr.version = DISK_SWAP_VERSION;
    else
        hdr.version = __builtin_bswap32(DISK_SWAP_VERSION);

    pwrite(fd, &hdr, sizeof(hdr), offset);
}

uint64_t parse_int_or_abort(const char* proc, const char* arg)
{
    errno = 0;
    uint64_t res = strtol(arg, 0, 0);
    if (errno != 0)
    {
        fprintf(stderr, "%s: Expected integer, got %s\n", proc, arg);
        exit(1);
    }
    return res;
}

uint64_t main(uint64_t argc, char** argv)
{
    if (argc < 3)
    {
        fprintf(stderr, "%s file sectorsize architecture [sizelimit] [offset]\n", argv[0]);
        return 1;
    }
    const char* filename = argv[1];
    uint64_t sectorsize = parse_int_or_abort(argv[0], argv[2]);
    const char* architecture = argv[3];
    uint64_t sizelimit = 0, offset = 0;
    if (argc == 6)
    {
        sizelimit = parse_int_or_abort(argv[0], argv[4]);
        offset = parse_int_or_abort(argv[0], argv[5]);
    }

    int fd = open(filename, O_WRONLY);
    if (fd < 0)
    {
        perror("open");
        return 2;
    }

    struct stat st = {};
    fstat(fd, &st);

    sizelimit = st.st_size;

    uint64_t pagesize = 0;
    uint64_t endianness = 0;
    if (strcmp(architecture, "x86_64") == 0)
    {
        pagesize = 0x1000;
        endianness = __ORDER_LITTLE_ENDIAN__;
    }
    else if (strcmp(architecture, "m68k") == 0)
    {
        pagesize = 0x1000;
        endianness = __ORDER_BIG_ENDIAN__;
    }
    else
    {
        fprintf(stderr, 
            "Unknown architecture '%s'!\n"
            "If OBOS supports this architecture and it does not exist here, make an issue at https://github.com/OBOS-dev/obos-pkgs\n", architecture);
        return 2;
    }
    

    errno = 0;
    make_disk_swap(fd, offset, sizelimit, sectorsize, pagesize, endianness);
    if (errno != 0)
        perror("pwrite");
    
    return 0;
}
