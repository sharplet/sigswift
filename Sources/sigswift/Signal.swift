// From signal(3):
//
// 1     SIGHUP       terminate process    terminal line hangup
// 2     SIGINT       terminate process    interrupt program
// 3     SIGQUIT      create core image    quit program
// 4     SIGILL       create core image    illegal instruction
// 5     SIGTRAP      create core image    trace trap
// 6     SIGABRT      create core image    abort program (formerly SIGIOT)
// 7     SIGEMT       create core image    emulate instruction executed
// 8     SIGFPE       create core image    floating-point exception
// 9     SIGKILL      terminate process    kill program
// 10    SIGBUS       create core image    bus error
// 11    SIGSEGV      create core image    segmentation violation
// 12    SIGSYS       create core image    non-existent system call invoked
// 13    SIGPIPE      terminate process    write on a pipe with no reader
// 14    SIGALRM      terminate process    real-time timer expired
// 15    SIGTERM      terminate process    software termination signal
// 16    SIGURG       discard signal       urgent condition present on socket
// 17    SIGSTOP      stop process         stop (cannot be caught or ignored)
// 18    SIGTSTP      stop process         stop signal generated from keyboard
// 19    SIGCONT      discard signal       continue after stop
// 20    SIGCHLD      discard signal       child status has changed
// 21    SIGTTIN      stop process         background read attempted from control terminal
// 22    SIGTTOU      stop process         background write attempted to control terminal
// 23    SIGIO        discard signal       I/O is possible on a descriptor (see fcntl(2))
// 24    SIGXCPU      terminate process    cpu time limit exceeded (see setrlimit(2))
// 25    SIGXFSZ      terminate process    file size limit exceeded (see setrlimit(2))
// 26    SIGVTALRM    terminate process    virtual time alarm (see setitimer(2))
// 27    SIGPROF      terminate process    profiling timer alarm (see setitimer(2))
// 28    SIGWINCH     discard signal       Window size change
// 29    SIGINFO      discard signal       status request from keyboard
// 30    SIGUSR1      terminate process    User defined signal 1
// 31    SIGUSR2      terminate process    User defined signal 2

import Darwin.C

enum Signal: Int32 {
  case HUP = 1
  case INT = 2
  case QUIT = 3
  case ILL = 4
  case TRAP = 5
  case ABRT = 6
  case EMT = 7
  case FPE = 8
  case KILL = 9
  case BUS = 10
  case SEGV = 11
  case SYS = 12
  case PIPE = 13
  case ALRM = 14
  case TERM = 15
  case URG = 16
  case STOP = 17
  case TSTP = 18
  case CONT = 19
  case CHLD = 20
  case TTIN = 21
  case TTOU = 22
  // swiftlint:disable:next identifier_name
  case IO = 23
  case XCPU = 24
  case XFSZ = 25
  case VTALRM = 26
  case PROF = 27
  case WINCH = 28
  case INFO = 29
  case USR1 = 30
  case USR2 = 31
}
