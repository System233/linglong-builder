

#include <dlfcn.h>
#include <fcntl.h>
#include <stdarg.h>
#include <stdio.h>
#include <unistd.h>
#include <dirent.h>
// extern DIR *(*original_opendir)(const char *name);
// extern FILE *(*original_freopen)(const char *filename, const char *mode, FILE *stream);
// extern int (*original_chmod)(const char *pathname, mode_t mode);
// extern int (*original_chown)(const char *pathname, uid_t owner, gid_t group);
// extern int (*original_fstat)(int fd, struct stat *statbuf);
// extern int (*original_link)(const char *old, const char *newPath);
// extern int (*original_lstat)(const char *pathname, struct stat *statbuf);
// extern int (*original_mkdir)(const char *pathname, mode_t mode);
extern int (*original_open)(const char *pathname, int flags, ...);
// extern int (*original_open64)(const char *pathname, int flags, ...);
// extern int (*original_rename)(const char *old, const char *newPath);
// extern int (*original_rmdir)(const char *pathname);
// extern int (*original_stat)(const char *pathname, struct stat *statbuf);
// extern int (*original_unlink)(const char *pathname);
// extern ssize_t (*original_readlink)(const char *path, char *buf, size_t bufsiz);
// extern struct dirent *(*original_readdir)(DIR *dirp);

// extern int (*original_openat)(int __fd, const char *__path, int __oflag, ...);
// extern int (*original_openat64)(int __fd, const char *__path, int __oflag, ...);
