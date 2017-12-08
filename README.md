# sigswift

This was actually an excuse to design a completely event-driven terminal program in Swift.
It's inspired by the [Elm Architecture][].

[![asciicast](https://asciinema.org/a/151764.png)](https://asciinema.org/a/151764?t=13)

How it works:

  - Sets the terminal to [raw mode][], to enable processing input
    character-by-character instead of line-by-line.

  - Configures a Grand Central Dispatch (GCD) `DispatchReadSource` to read from
    standard input one character at a time.

  - Configures a number of GCD `DispatchSignalSource`s to process signals as
    events.

  - With the event handlers in place, models the application as an `App` struct
    that receives an `Event`, optionally updates its state, and dispatches an
    array of `Action`.

  - No side effects are implemented in `App`, but are instead implemented in
    top-level functions `handle()` and `dispatch()`, which convert `Action`s
    into side effects.

[Elm Architecture]: https://talk.objc.io/episodes/S01E66-the-elm-architecture-part-1
[raw mode]: https://viewsourcecode.org/snaptoken/kilo/02.enteringRawMode.html
