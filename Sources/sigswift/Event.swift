import class Foundation.ProcessInfo

enum Event {
  case cancelExit
  case endOfInput
  case `init`(ProcessInfo)
  case keyboard(UnicodeScalar)
  case keyboardReadError(Error)
  case signal(Signal)
}
