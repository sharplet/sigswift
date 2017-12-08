import Foundation
import setraw

var app = App()

func handle(_ event: Event) {
  let actions = app.handleEvent(event)
  dispatch(actions)
}

func dispatch(_ actions: [App.Action]) {
  for action in actions {
    switch action {
    case .exit:
      exit(0)

    case let .print(output):
      print(output, terminator: "")
      fflush(stdout)

    case let .schedule(event, after: interval):
      DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
        handle(event)
      }
    }
  }
}

// Ensure app is initialised before any other event is handled.

DispatchQueue.main.async {
  handle(.init(.processInfo))
}

// Set up keyboard event source

setraw()

let keys = DispatchSource.makeReadSource(fileDescriptor: STDIN_FILENO, queue: nil)
keys.setEventHandler {
  do {
    guard let character = try readCharacter() else { exit(0) }
    handle(.keyboard(character))
  } catch POSIXError.EAGAIN {
    return
  } catch POSIXError.EINTR {
    return
  } catch {
    die(error)
  }
}
keys.resume()

// Set up signal sources

func handleSignal(_ signal: Signal) {
  handle(.signal(signal))
}

let hup = Signal.registerHandler(signal: .HUP, handler: handleSignal)
let int = Signal.registerHandler(signal: .INT, handler: handleSignal)
let term = Signal.registerHandler(signal: .TERM, handler: handleSignal)
let usr1 = Signal.registerHandler(signal: .USR1, handler: handleSignal)
let usr2 = Signal.registerHandler(signal: .USR2, handler: handleSignal)

dispatchMain()
