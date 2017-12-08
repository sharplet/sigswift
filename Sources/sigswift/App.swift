import func Darwin.C.iscntrl
import enum Dispatch.DispatchTimeInterval

struct App {
  enum Action {
    case exit
    case schedule(Event, after: DispatchTimeInterval)
    case print(String)
  }

  private var confirming = false

  mutating func handleEvent(_ event: Event) -> [Action] {
    switch event {
    case .cancelExit:
      confirming = false
      return [.print("\n")]

    case .init:
      return [.print("Try sending a signal!\n")]

    case .keyboard where self.confirming:
      return []

    case .keyboard(.EOT):
      return [.exit]

    case let .keyboard(character) where character.isLineSeparator:
      return [.print("\n")]

    case let .keyboard(character) where character.isBackspace:
      return [.print(.destructiveBackspace)]

    case let .keyboard(character) where character.isControlCode:
      return [.print(character.escaped(asASCII: false))]

    case let .keyboard(character):
      return [.print(String(character))]

    case .signal(.INT) where self.confirming:
      return [.print("\n"), .exit]

    case .signal(.INT):
      confirming = true
      return [.print("Exit? (^C to confirm)"), .schedule(.cancelExit, after: .seconds(2))]

    case .signal:
      return []
    }
  }
}
