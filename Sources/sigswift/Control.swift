// swiftlint:disable identifier_name

import func Darwin.C.iscntrl

extension String {
  static let destructiveBackspace = "\u{8}\u{20}\u{8}"
}

extension UnicodeScalar {
  static let EOT = UnicodeScalar(4 as UInt8)
  static let BS = UnicodeScalar(8 as UInt8)
  static let LF = UnicodeScalar(10 as UInt8)
  static let CR = UnicodeScalar(13 as UInt8)

  var isBackspace: Bool {
    return self == .BS || self == "\u{7F}"
  }

  var isControlCode: Bool {
    return isASCII && iscntrl(Int32(value)) != 0
  }

  var isLineSeparator: Bool {
    return self == .LF || self == .CR
  }
}
