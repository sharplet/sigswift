import class Foundation.ProcessInfo

enum Event {
  case cancelExit
  case `init`(ProcessInfo)
  case keyboard(UnicodeScalar)
  case signal(Signal)
}
