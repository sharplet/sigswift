import Darwin.C
import Dispatch

func backspace() {
  putchar(8)
  putchar(32)
  putchar(8)
}

signal(SIGINT, SIG_IGN)

var confirming = false

let int = DispatchSource.makeSignalSource(signal: SIGINT, queue: nil)
int.setEventHandler {
  if isatty(fileno(stdout)) != 0 {
    backspace()
    backspace()
  }

  if confirming {
    print()
    exit(0)
  }

  print("Exit? (^C to confirm)", terminator: "")
  fflush(stdout)

  confirming = true
  DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    confirming = false
    print()
  }
}
int.resume()

print("Try sending a signal!")

dispatchMain()
