import Foundation

func readCharacter(fileDescriptor: Int32 = STDIN_FILENO) throws -> UnicodeScalar {
  var char = 0 as UInt8
  let bytesRead = withUnsafeMutablePointer(to: &char) {
    read(fileDescriptor, $0, 1)
  }

  switch bytesRead {
  case 0:
    return .EOT
  case 1:
    return UnicodeScalar(char)
  default:
    throw NSError(domain: POSIXError.errorDomain, code: Int(errno))
  }
}
