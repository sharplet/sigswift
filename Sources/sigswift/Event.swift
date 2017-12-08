enum Event {
  case cancelExit
  case `init`
  case keyboard(UnicodeScalar)
  case signal(Signal)
}
