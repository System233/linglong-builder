#define _FILE_OFFSET_BITS 64
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/sendfile.h>
#include <sys/stat.h>
#include <unistd.h>

int main(int argc, char const *argv[])
{
    if (argc < 2)
    {
        fprintf(stderr, "%s <file>\n", argv[0]);
        return 1;
    }
    {
        struct stat s;
        if (stat(argv[1], &s) == -1)
        {
            perror("stat");
            return 1;
        }
        int fd = open(argv[1], O_RDWR);
        if (fd == -1)
        {
            perror("open");
            return 1;
        }

        // if (fstat(fd, &s) == -1)
        // {
        //     perror("stat");
        //     return 1;
        // }
        if (sendfile(fileno(stdout), fd, 0, s.st_size) == -1)
        {
            perror("sendfile");
        };
        close(fd);
    }
    {
        struct stat s;
        if (stat(argv[1], &s) == -1)
        {
            perror("stat");
            return 1;
        }
        int fd = open(argv[1], O_RDWR);
        if (fd == -1)
        {
            perror("open");
            return 1;
        }

        // if (fstat(fd, &s) == -1)
        // {
        //     perror("stat");
        //     return 1;
        // }
        if (sendfile(fileno(stdout), fd, 0, s.st_size) == -1)
        {
            perror("sendfile");
        };
        close(fd);
    }

    return 0;
}
