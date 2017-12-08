#include <err.h>
#include <stdlib.h>
#include <termios.h>
#include <unistd.h>

static struct termios orig_termios;

void unsetraw(void) {
  if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &orig_termios) == -1) {
    err(1, NULL);
  }
}

void setraw(void) {
  if (tcgetattr(STDIN_FILENO, &orig_termios) == -1) {
    err(1, NULL);
  }
  atexit(unsetraw);

  struct termios raw = orig_termios;
  raw.c_cflag |= (CS8);
  raw.c_iflag &= ~(BRKINT | INPCK | ISTRIP | IXON);
  raw.c_lflag &= ~(ECHO | ICANON | IEXTEN);

  if (tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw) == -1) {
    err(1, NULL);
  };
}
