// #define _FILE_OFFSET_BITS 64
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <sys/user.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
// #include <linux/fcntl.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <libgen.h>
#include <sys/sendfile.h>
#include <sys/stat.h>
#include <syslog.h>
#include <seccomp.h>
#include <signal.h>
#include <linux/prctl.h>
#include <sys/prctl.h>
#include <stddef.h>
#include <sys/ptrace.h>
#include <sys/reg.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <sys/user.h>
#include <fcntl.h>
#include <linux/limits.h>
#include <linux/bpf.h>
#include <linux/filter.h>

#define TARGET_PATH "/tmp/modified_path.txt"
#define ORIGINAL_PATH "/tmp/original_path.txt"
#define PATH_MAX 4096

char const *upper;
char lower[PATH_MAX];
int upperLen = 0;
int upperFd = 0;

static int copy(char const *src, char const *dest)
{
    int ret = -1, ifd = 0, ofd = 0;
    struct stat s;
    if ((ret = stat(src, &s)) != 0)
    {
        syslog(LOG_ERR, "stat: %s:%s", src, strerror(errno));
        return ret;
    }
    if ((ifd = open(src, O_RDONLY)) == -1)
    {
        syslog(LOG_ERR, "open: %s:%s", src, strerror(errno));
        ret = -1;
        goto end;
    }
    if ((ofd = open(dest, O_WRONLY | O_CREAT | O_TRUNC, s.st_mode)) == -1)
    {
        syslog(LOG_ERR, "open: %s:%s", dest, strerror(errno));
        ret = -1;
        goto end;
    }
    ret = sendfile(ofd, ifd, NULL, s.st_size);
    if (ret == -1)
    {
        syslog(LOG_ERR, "sendfile: ofd=%d, ifd=%d: %s", ofd, ifd, strerror(errno));
    }
end:
    if (ifd != -1)
    {
        close(ifd);
    }
    if (ofd != -1)
    {
        close(ofd);
    }
    return ret;
}
static void redirect(char const *raw, char const *rel_path)
{
    static char path[PATH_MAX];
    // if (rel_path[0] == '.' && rel_path[1] == '/')
    // {
    //     rel_path += 2;
    // }
    snprintf(path, PATH_MAX, "%s/%s", upper, rel_path);

    struct stat buf;
    if (stat(raw, &buf) != -1 && S_ISREG(buf.st_mode) && access(path, F_OK) == -1)
    {
        for (int i = strlen(upper); path[i]; ++i)
        {
            if (path[i] == '/' && i)
            {
                path[i] = 0;
                syslog(LOG_DEBUG, "mkdir: %s", path);
                if (mkdir(path, 0777) == -1 && errno != EEXIST)
                {
                    syslog(LOG_ERR, "mkdir: %s:%s", path, strerror(errno));
                }
                path[i] = '/';
            }
        }
        syslog(LOG_DEBUG, "copy: %s -> %s", raw, path);
        if (copy(raw, path) == -1)
        {
            syslog(LOG_ERR, "copy: %s -> %s", raw, path, strerror(errno));
        }
    }
}
char const *pathcmp(char const *lower, char const *dest)
{
    int i = 0;
    char const *p1 = lower;
    char const *p2 = dest;
    while (*p1 && *p2)
    {

        while (*p1 == '/')
            p1++;
        while (*p2 == '/')
            p2++;
        if (*p1++ != *p2++)
        {
            return NULL;
        }
    }
    if (!*p1)
    {
        while (*p2 == '/')
            p2++;
        return p2;
    }
    return NULL;
}
size_t peek_string(pid_t pid, char *buffer, size_t size, long addr)
{
    for (size_t i = 0, flag = 1; flag && i < size; i += sizeof(long))
    {
        long *pData = (long *)&buffer[i];
        long data = ptrace(PTRACE_PEEKDATA, pid, addr + i, NULL);
        if (data == -1)
        {
            syslog(LOG_ERR, "ptrace: addr=%p, %s", addr, strerror(errno));
            buffer[i] = 0;
            return i;
        }
        *pData = data;
        for (int j = 0; j < sizeof(long); ++j)
        {
            if (buffer[i + j] == 0)
            {
                flag = 0;
                return i;
            }
        }
    }
}
#define FILTER (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR | O_APPEND | O_EXCL)
char const *strflag(int flag)
{
    if (flag == 0)
    {
        return "O_RDONLY";
    }
    static char data[1024];
    char *next = data;
    *next = 0;
#define _XCAT(X)                                                 \
    if (flag & X)                                                \
        strncat(data, #X "|", sizeof(data) - (next - data) - 1); \
    next += sizeof(#X "|");
#ifdef __O_CLOEXEC
    _XCAT(__O_CLOEXEC);
#endif
#ifdef __O_DIRECT
    _XCAT(__O_DIRECT);
#endif
#ifdef __O_DIRECTORY
    _XCAT(__O_DIRECTORY);
#endif
#ifdef __O_DSYNC
    _XCAT(__O_DSYNC);
#endif
#ifdef __O_LARGEFILE
    _XCAT(__O_LARGEFILE);
#endif
#ifdef __O_NOATIME
    _XCAT(__O_NOATIME);
#endif
#ifdef __O_NOFOLLOW
    _XCAT(__O_NOFOLLOW);
#endif
#ifdef __O_PATH
    _XCAT(__O_PATH);
#endif
#ifdef __O_TMPFILE
    _XCAT(__O_TMPFILE);
#endif
#ifdef O_ACCMODE
    _XCAT(O_ACCMODE);
#endif
#ifdef O_APPEND
    _XCAT(O_APPEND);
#endif
#ifdef O_ASYNC
    _XCAT(O_ASYNC);
#endif
#ifdef O_CLOEXEC
    _XCAT(O_CLOEXEC);
#endif
#ifdef O_CREAT
    _XCAT(O_CREAT);
#endif
#ifdef O_DIRECT
    _XCAT(O_DIRECT);
#endif
#ifdef O_DIRECTORY
    _XCAT(O_DIRECTORY);
#endif
#ifdef O_DSYNC
    _XCAT(O_DSYNC);
#endif
#ifdef O_EXCL
    _XCAT(O_EXCL);
#endif
#ifdef O_FSYNC
    _XCAT(O_FSYNC);
#endif
#ifdef O_LARGEFILE
    _XCAT(O_LARGEFILE);
#endif
#ifdef O_NDELAY
    _XCAT(O_NDELAY);
#endif
#ifdef O_NOATIME
    _XCAT(O_NOATIME);
#endif
#ifdef O_NOCTTY
    _XCAT(O_NOCTTY);
#endif
#ifdef O_NOFOLLOW
    _XCAT(O_NOFOLLOW);
#endif
#ifdef O_NONBLOCK
    _XCAT(O_NONBLOCK);
#endif
#ifdef O_PATH
    _XCAT(O_PATH);
#endif
#ifdef O_RDONLY
    _XCAT(O_RDONLY);
#endif
#ifdef O_RDWR
    _XCAT(O_RDWR);
#endif
#ifdef O_RSYNC
    _XCAT(O_RSYNC);
#endif
#ifdef O_SYNC
    _XCAT(O_SYNC);
#endif
#ifdef O_TMPFILE
    _XCAT(O_TMPFILE);
#endif
#ifdef O_TRUNC
    _XCAT(O_TRUNC);
#endif
#ifdef O_WRONLY
    _XCAT(O_WRONLY);
#endif
    return data;
}
void trace_openat_path(pid_t pid)
{
    //[event][sig][x]
    int status;
    struct user_regs_struct regs;
    char path[PATH_MAX];
    char resolved[PATH_MAX];
    char const *diff = NULL;

    // ptrace(PTRACE_EVENT_SECCOMP, pid, NULL, NULL);

    // ptrace(PTRACE_SYSCALL, pid, NULL, NULL);
    pid = waitpid(-1, &status, 0);

    // ptrace(PTRACE_SYSCALL, pid, NULL, NULL);
    while (!WIFEXITED(status))
    {

        if (status >> 8 == (SIGTRAP | (PTRACE_EVENT_CLONE << 8)))
        {
            int new_pid = -1;
            ptrace(PTRACE_GETEVENTMSG, pid, NULL, &new_pid);
            printf("[%d] A clone event has occurred! New PID:%d\n", pid, new_pid);
        }
        // if (WIFSTOPPED(status) && WSTOPSIG(status) == SIGTRAP)
        // {
        //     // 处理 ptrace 事件
        //     int pid;
        //     ptrace(PTRACE_GETEVENTMSG, pid, NULL, &pid);
        //     // printf("New process created with PID: %d\n", pid);
        // }
        // ptrace(PTRACE_GETREGS, pid, NULL, &regs);

        // syslog(LOG_DEBUG, "syscall: id=%d", regs.orig_eax);
        // FD, PATH, FLAG, MODE
        // EBX,ECX , EDX,  E
        // if (regs.orig_eax == SYS_openat && WIFSTOPPED(status) && WSTOPSIG(status) == SIGTRAP)
        // {
        //     if (peek_string(pid, path, PATH_MAX, regs.ecx))
        //     {
        //         syslog(LOG_DEBUG, "[%d] openat: fd=%d, flags=%s", pid, regs.ebx, path, strflag(regs.edx));
        //     }
        // }
        // if (regs.orig_eax == SYS_openat && regs.ebx == AT_FDCWD && ((regs.edx & (FILTER)) && (~(regs.edx & O_DIRECTORY))))
        // {
        //     // long path_addr = regs.ecx; // + sizeof(long); // ebx 是第一个参数
        //     // peek_string(pid, path, PATH_MAX, path_addr);
        //     // syslog(LOG_DEBUG, "openat: AT_FDCWD %s, flags=%s", path, strflag(regs.edx));
        //     // syslog(LOG_DEBUG, "openat: AT_FDCWD %s, match=%s", path, strflag(regs.edx & (FILTER)));
        //     // if (*path != '/')
        //     // {
        //     //     regs.ebx = upperFd;
        //     //     regs.ecx = path_addr;
        //     //     redirect(path, path);

        //     //     syslog(LOG_DEBUG, "openat: %s -> %s/%s, flag=%s", path, upper, path, strflag(regs.edx));
        //     //     ptrace(PTRACE_SETREGS, pid, NULL, &regs);
        //     // }
        //     // else if ((diff = pathcmp(lower, path)) != NULL)
        //     // {
        //     //     regs.ebx = upperFd;
        //     //     regs.ecx = path_addr + (diff - path);
        //     //     redirect(path, diff);
        //     //     syslog(LOG_DEBUG, "openat: %s -> %s/%s, flag=%s", path, upper, diff, strflag(regs.edx));
        //     //     ptrace(PTRACE_SETREGS, pid, NULL, &regs);
        //     // }
        //     // else
        //     // {
        //     //     // syslog(LOG_DEBUG, "openat: skip %s", path);
        //     // }
        // }
        // else if (regs.orig_eax == SYS_stat64)
        // {

        //     long path_addr = regs.ebx;
        //     if (peek_string(pid, path, PATH_MAX, path_addr))
        //     {
        //         struct stat buf;
        //         syslog(LOG_DEBUG, "stat: %s", path);
        //         // if (*path != '/')
        //         // {
        //         //     int fd = openat(upperFd, path, O_RDONLY);
        //         //     if (fd != -1)
        //         //     {
        //         //         syslog(LOG_DEBUG, "stat: %s -> %s/%s, fd=%d", path, upper, path, fd);
        //         //         fstat(fd, &buf);
        //         //         close(fd);
        //         //         regs.eax = 10000;
        //         //         for (size_t i = 0; i < sizeof(buf); i += sizeof(long))
        //         //         {
        //         //             long data = *(long *)(((char *)&buf) + i);
        //         //             ptrace(PTRACE_POKEDATA, pid, regs.ecx + i, data);
        //         //         }
        //         //         ptrace(PTRACE_SETREGS, pid, NULL, &regs);
        //         //     }

        //         //     // regs.eax = SYS_fstat;
        //         //     // regs.ebx = fd;
        //         //     // syslog(LOG_DEBUG, "stat1: %s -> %s/%s, fd=%d", path, upper, path, regs.ebx);
        //         //     // ptrace(PTRACE_SETREGS, pid, NULL, &regs);
        //         // }
        //         // else if ((diff = pathcmp(lower, path)) != NULL)
        //         // {
        //         //     int fd = openat(upperFd, diff, O_RDONLY);
        //         //     if (fd != -1)
        //         //     {
        //         //         syslog(LOG_DEBUG, "stat: %s -> %s/%s, fd=%d", path, upper, diff, fd);
        //         //         // fd = openat(AT_FDCWD, path, O_RDONLY);
        //         //         fstat(fd, &buf);
        //         //         close(fd);

        //         //         regs.eax = 10000;
        //         //         for (size_t i = 0; i < sizeof(buf); i += sizeof(long))
        //         //         {
        //         //             long data = *(long *)(((char *)&buf) + i);
        //         //             ptrace(PTRACE_POKEDATA, pid, regs.ecx + i, data);
        //         //         }
        //         //         ptrace(PTRACE_SETREGS, pid, NULL, &regs);
        //         //     }
        //         //     // regs.eax = SYS_fstat64;
        //         //     // regs.ebx = fd;
        //         //     // syslog(LOG_DEBUG, "stat2: %s -> %s/%s, fd=%d", path, upper, diff, regs.ebx);
        //         //     // ptrace(PTRACE_SETREGS, pid, NULL, &regs);
        //         // }
        //     }
        // }

        // ptrace(PTRACE_SYSCALL, pid, NULL, NULL);
        ptrace(PTRACE_CONT, pid, NULL, NULL);

        // ptrace(PTRACE_EVENT_SECCOMP, pid, NULL, NULL);

        pid = waitpid(-1, &status, 0);
    }
}
void setuplog()
{
    const char *log_level = getenv("PTRACE_LOG_LEVEL");
    int mask = LOG_UPTO(LOG_WARNING);

    if (log_level != NULL)
    {
        if (strcmp(log_level, "DEBUG") == 0)
        {
            mask = LOG_UPTO(LOG_DEBUG);
        }
        else if (strcmp(log_level, "INFO") == 0)
        {
            mask = LOG_UPTO(LOG_INFO);
        }
        else if (strcmp(log_level, "WARNING") == 0)
        {
            mask = LOG_UPTO(LOG_WARNING);
        }
        else if (strcmp(log_level, "ERROR") == 0)
        {
            mask = LOG_UPTO(LOG_ERR);
        }
    }

    setlogmask(mask);
}

int main(int argc, char *argv[])
{
    openlog(argv[0], LOG_PID | LOG_CONS | LOG_PERROR, LOG_USER);
    setuplog();
    if (argc < 3)
    {
        fprintf(stderr, "Usage: %s <CWD> <program>\n", argv[0]);
        return 1;
    }

    getcwd(lower, sizeof(lower));
    upperLen = strlen(lower);
    upper = argv[1];
    if ((upperFd = open(upper, O_RDONLY | O_DIRECTORY)) == -1)
    {
        syslog(LOG_ERR, "open: %s", upper, strerror(errno));
        return 1;
    }
    syslog(LOG_DEBUG, "cwd: %s", lower);
    syslog(LOG_DEBUG, "redirect: %s", upper);
    pid_t child = fork();
    if (child == 0)
    {
        struct sock_filter filter[] = {
            BPF_STMT(BPF_LD + BPF_W + BPF_ABS, offsetof(struct seccomp_data, nr)),
            BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, SYS_openat, 0, 1),
            BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_TRACE),
            BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, SYS_stat64, 0, 1),
            BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_TRACE),
            BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_ALLOW),
        };
        struct sock_fprog prog = {
            .filter = filter,
            .len = (unsigned short)(sizeof(filter) / sizeof(filter[0])),
        };
        ptrace(PTRACE_TRACEME, 0, NULL, NULL);

        if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) == -1)
        {
            perror("prctl(PR_SET_NO_NEW_PRIVS)");
            return 1;
        }
        if (prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER, &prog) == -1)
        {
            perror("when setting seccomp filter");
            return 1;
        }
        kill(getpid(), SIGSTOP);
        int ret = execv(argv[2], &argv[2]);
        syslog(LOG_ERR, "execv: %s", argv[2], strerror(errno));
        return ret;
    }
    else
    {
        int status;
        waitpid(child, &status, 0);
        ptrace(PTRACE_SETOPTIONS, child, 0, PTRACE_O_TRACESECCOMP
               // | PTRACE_O_TRACECLONE
        );
        ptrace(PTRACE_CONT, child, 0, 0);
        trace_openat_path(child);
    }

    closelog();
    return 0;
}
