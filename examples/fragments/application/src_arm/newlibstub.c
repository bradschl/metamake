#include <errno.h>
#include <sys/stat.h>
#include <sys/times.h>
#include <sys/unistd.h>

char *__env[1] = { 0 };
char **environ = __env;


int _kill( int pid, int sig )
{
    return -1;
}

void _exit(int status)
{
    while(1)
    {
        ;
    }
}

int _close(int file) 
{ 
    return -1;
}

int _fstat(int file, struct stat *st) 
{
    st->st_mode = S_IFCHR;
    return 0;
}

int _isatty(int file) 
{ 
    return 1; 
}

int _lseek(int file, int ptr, int dir) 
{ 
    return 0; 
}

int _open(const char *name, int flags, int mode) 
{ 
    return -1; 
}

int _read(int file, char *ptr, int len) 
{
    return 0;
}

int _write(int file, char *ptr, int len) 
{
    return len;
}

int _execve(char *name, char **argv, char **env) {
    errno = ENOMEM;
    return -1;
}


int _fork() {
    errno = EAGAIN;
    return -1;
}

int _getpid() {
    return 1;
}


int _link(char *old, char *new) {
    errno = EMLINK;
    return -1;
}



char * NEWLIB_currentHeapEnd = 0;
caddr_t _sbrk(int incr) {

    //extern char _ebss; // Defined by the linker
    extern char _user_heap_start_;  // Defined by the linker
    extern char _user_heap_end_;    // Defined by the linker

    if (NEWLIB_currentHeapEnd == 0) {
        NEWLIB_currentHeapEnd = &_user_heap_start_;
    }
    char *prev_heap_end = NEWLIB_currentHeapEnd;

    if( (NEWLIB_currentHeapEnd + incr) >= &_user_heap_end_)
    {
        errno = ENOMEM;
        return  (caddr_t) -1;
    }

    NEWLIB_currentHeapEnd += incr;
    return (caddr_t) prev_heap_end;
}


int _stat(const char *filepath, struct stat *st) {
    st->st_mode = S_IFCHR;
    return 0;
}

clock_t _times(struct tms *buf) {
    return -1;
}

int _unlink(char *name) {
    errno = ENOENT;
    return -1;
}

int _wait(int *status) {
    errno = ECHILD;
    return -1;
}

int __register_exitproc (int a, void (*fn) (void), void *b, void *c)
{
    return 1;
}

