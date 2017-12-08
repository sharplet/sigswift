// swiftlint:disable identifier_name

import func Darwin.C.iscntrl

extension UnicodeScalar {
  static let EOT = UnicodeScalar(4 as UInt8)
  static let LF = UnicodeScalar(10 as UInt8)
  static let CR = UnicodeScalar(13 as UInt8)

  var isControlCode: Bool {
    return isASCII && iscntrl(Int32(value)) != 0
  }

  var isLineSeparator: Bool {
    return self == .LF || self == .CR
  }
}
