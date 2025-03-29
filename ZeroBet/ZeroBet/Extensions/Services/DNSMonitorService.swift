import Foundation

struct DNSMonitorService {
    static func extractDomain(from packet: Data) -> String? {
        let bytes = [UInt8](packet)
        guard bytes.count > 12 else { return nil }

        var domain = ""
        var pos = 12 // DNS header size

        while pos < bytes.count {
            let len = Int(bytes[pos])
            if len == 0 { break }
            pos += 1
            if pos + len > bytes.count { break }

            let label = bytes[pos..<pos+len].map { String(format: "%c", $0) }.joined()
            domain += label + "."
            pos += len
        }

        return domain.isEmpty ? nil : domain
    }
}
