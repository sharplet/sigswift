import Foundation
import setraw

setraw()
signal(SIGINT, SIG_IGN)

var confirming = false

let int = DispatchSource.makeSignalSource(signal: SIGINT, queue: nil)
int.setEventHandler {
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

let keys = DispatchSource.makeReadSource(fileDescriptor: STDIN_FILENO, queue: nil)
keys.setEventHandler {
  do {
    guard let char = try readCharacter() else { exit(0) }
    if confirming { return } // swallow input
    if char.value == 4 { exit(0) } // EOT
    print(char.escaped(asASCII: true))
  } catch POSIXError.EAGAIN {
    return
  } catch POSIXError.EINTR {
    return
  } catch {
    die(error)
  }
}
keys.resume()

print("Try sending a signal!")

dispatchMain()
