import Foundation

struct UseSessionModel: Identifiable, Codable {
    var id: UUID
    var dominio: String
    var inicio: Date
    var ultimoAcesso: Date

    var duracao: TimeInterval {
        return ultimoAcesso.timeIntervalSince(inicio)
    }

    // Valor padrão caso você queira instanciar manualmente:
    init(id: UUID = UUID(), dominio: String, inicio: Date, ultimoAcesso: Date) {
        self.id = id
        self.dominio = dominio
        self.inicio = inicio
        self.ultimoAcesso = ultimoAcesso
    }
}
