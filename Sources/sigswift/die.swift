import func Darwin.C.exit
import func Darwin.C.fputs
import var Darwin.C.stderr

func die(_ error: Error) -> Never {
  let message = String(describing: error)
  die(message)
}

func die(_ message: String) -> Never {
  fputs(message + "\n", stderr)
  exit(1)
}
