import Foundation

struct DNSMonitorService {
    static func extractDomain(from packet: Data) -> String? {
        let bytes = [UInt8](packet)
        guard bytes.count > 12 else {
            print("📛 Pacote pequeno demais para ser DNS.")
            return nil
        }

        var domain = ""
        var pos = 12 // DNS header size

        while pos < bytes.count {
            let len = Int(bytes[pos])
            if len == 0 { break }
            pos += 1
            if pos + len > bytes.count { break }

            let label = bytes[pos..<pos+len]
                .filter { $0 >= 32 && $0 <= 126 } // caracteres visíveis
                .map { String(format: "%c", $0) }
                .joined()

            domain += label + "."
            pos += len
        }

        if domain.isEmpty {
            print("⚠️ Nenhum domínio encontrado no pacote DNS.")
        }

        return domain.isEmpty ? nil : domain
    }
}
