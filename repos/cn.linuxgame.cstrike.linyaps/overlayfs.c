/*
# Copyright (c) 2024 System233
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT
*/

// #define _GNU_SOURCE
// #include "overlayfs.h"
#include <dlfcn.h>
#include <stdarg.h>
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <dirent.h>
#include <string.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <libgen.h>
#include <sys/sendfile.h>
#include <errno.h>
// extern FILE *stdin;
// extern FILE *stdout;
// extern FILE *stderr;
// #define EEXIST -17
// extern int errno;
// extern void *dlsym(void *__restrict __handle,
//                    const char *__restrict __name);
// int printf(const char *__restrict __fmt, ...);
// typedef int mode_t;
// typedef void FILE;
// typedef int size_t;
// extern char *getenv(const char *__name);
// extern void *malloc(size_t __size);
// extern void free(void *__ptr);
// #define RTLD_NEXT (void *)-
#define RTLD_NEXT ((void *)-1l)
#define STD_HOOK(ret_value, name, ...)                                                                 \
    static ret_value (*original_##name)(__VA_ARGS__);                                                  \
    void __attribute__((constructor)) init_##name(void) { original_##name = dlsym(RTLD_NEXT, #name); } \
    ret_value name(__VA_ARGS__)

#define MAX_PATH 4096
#define MAX_LOWER_DIRS 10
#define O_WRITE 020000000 | 00200000 | 0100
#define TAG "huse-overlayfs2:"
#define LOG_ERR(NAME, FMT, ...) fprintf(stderr, TAG #NAME " fail: code=%d," #FMT "\n", errno, __VA_ARGS__)

// #define X O_RDWR | O_CREAT

// #define O_RDONLY 0
// #define O_CREAT 0100
// #define O_TRUNC 01000
// #define O_APPEND 02000
// #define O_WRONLY 01
// #define O_RDWR 02
// /* Values for the second argument to access.
//    These may be OR'd together.  */
// #define R_OK 4 /* Test for read permission.  */
// #define W_OK 2 /* Test for write permission.  */
// #define X_OK 1 /* Test for execute permission.  */
// #define F_OK 0 /* Test for existence.  */
// extern size_t sendfile(int __out_fd, int __in_fd, mode_t *__offset,
//                        size_t __count);
// extern int open(const char *__path, int __oflag, ...);
// extern int mkdir(const char *__path, mode_t __mode);
// extern int close(int __fd);
#define O_MUTABLE O_CREAT | O_TRUNC | O_APPEND | O_WRONLY | O_RDWR

static char const *lower;
static char const *upper;
void __attribute__((constructor)) init_env()
{
    fprintf(stderr, TAG "!!!!loaded\n");
    lower = getenv("OVERLAYFS_LOWER");
    upper = getenv("OVERLAYFS_UPPER");
    fprintf(stderr, TAG "OVERLAYFS_LOWER=%s\n", lower ? lower : "null");
    fprintf(stderr, TAG "OVERLAYFS_UPPER=%s\n", upper ? upper : "null");
}
static char *mkdirs2(char const *raw, char const *ref)
{
    char const *current = upper;
    char const *next = ref;
    int ret = 0;
    char *path = malloc(MAX_PATH);
    int i = 0;
    do
    {
        if (i && (*current == '/' || (!*current && next)))
        {
            path[i] = 0;
            ret = mkdir(path, 0755);
            if (ret == -1 && errno != EEXIST)
            {
                LOG_ERR("mkdirs2", "path=%s", path);
                goto err;
            }
            fprintf(stderr, TAG "mkdir: %s\n", path);
        }
        if (!*current)
        {
            if (!next)
            {
                break;
            }
            path[i++] = '/';
            current = next;
            next = 0;
        }
        else
        {
            path[i++] = *current++;
        }
    } while (*current && i < MAX_PATH);
    if (access(raw, F_OK) == 0 && access(path, F_OK) == -1)
    {
        struct stat s;
        int ifd = 0, ofd = 0;
        stat(raw, &s);
        if ((ifd = open(raw, O_RDONLY)) != -1 && (ofd = open(path, O_CREAT)) != -1)
        {
            if (sendfile(ofd, ifd, 0, s.st_size) == -1)
            {
                LOG_ERR("sendfile", "ofd=%d, ifd=%d", ofd, ifd);
                goto err;
            };

            fprintf(stderr, TAG "cp: %s\n", ref);
        }
        if (ifd != -1)
        {
            close(ifd);
        }
        if (ofd != -1)
        {
            close(ofd);
        }
    }
    return path;
err:
    free(path);
    return NULL;
}

STD_HOOK(int, open, const char *__path, int __oflag, ...)
{
    fprintf(stderr, TAG "open:%s\n", __path);
    int ret = 0;
    va_list args;
    va_start(args, __oflag);
    mode_t mode = (__oflag & O_WRITE) ? va_arg(args, mode_t) : 0;
    va_end(args);
    return original_open(__path, __oflag, mode);
}
STD_HOOK(int, openat_2, int __fd, const char *__path, int __oflag, ...)
{
    fprintf(stderr, TAG "__openat_2:%s\n", __path);
    int ret = 0;
    va_list args;
    va_start(args, __oflag);
    mode_t mode = (__oflag & O_WRITE) ? va_arg(args, mode_t) : 0;
    va_end(args);
    // printf("Hooked openat: %s, flags=%X,mode=%o\n", __path, __oflag, mode);
    // redirect_path(pathname, flags & O_WRITE | O_APPEND |);
    if (lower && upper && __oflag != O_RDONLY)
    {
        for (char const *i = lower, *j = __path; *j; ++i, ++j)
        {
            if (*i == 0)
            {
                if (*j != '/')
                {
                    break;
                }
                char *newPath = mkdirs2(__path, j);
                if (!newPath)
                {
                    break;
                }
                fprintf(stderr, TAG "redirect %s to %s \n", __path, newPath);
                int result = original_openat_2(__fd, newPath, __oflag, mode);
                free(newPath);
                return result;
            }
            if (*i != *j)
            {
                break;
            }
        }
    }
    int result = original_openat_2(__fd, __path, __oflag, mode);
    return result;
}