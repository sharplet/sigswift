import enum Dispatch.DispatchTimeInterval

struct App {
  enum Action {
    case exit
    case schedule(Event, after: DispatchTimeInterval)
    case print(String)
    case prompt(String)
  }

  private var confirming = false

  mutating func handleEvent(_ event: Event) -> [Action] {
    switch event {
    case .cancelExit:
      confirming = false
      return [.print("")]

    case .init:
      return [.print("Try sending a signal!")]

    case .keyboard where self.confirming:
      return []

    case .keyboard(.EOT):
      return [.exit]

    case let .keyboard(character):
      return [.print(character.escaped(asASCII: true))]

    case .signal(.INT) where self.confirming:
      return [.print(""), .exit]

    case .signal(.INT):
      confirming = true
      return [.prompt("Exit? (^C to confirm)"), .schedule(.cancelExit, after: .seconds(2))]

    case .signal:
      return []
    }
  }
}
