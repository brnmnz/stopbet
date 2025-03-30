import Foundation

class SessionMonitorService {
    static let shared = SessionMonitorService()
    
    private var sessoesAtivas: [String: UseSessionModel] = [:]
    private var sessoesEncerradas: [UseSessionModel] = []
    private let tempoInatividade: TimeInterval = 300 // 5 minutos
    private var timer: Timer?

    private init() {
        iniciarTimer()
    }

    private func iniciarTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.verificarInatividade()
        }
    }

    func registrarAcesso(dominio: String) {
        let agora = Date()

        if var sessao = sessoesAtivas[dominio] {
            sessao.ultimoAcesso = agora
            sessoesAtivas[dominio] = sessao
        } else {
            let novaSessao = UseSessionModel(dominio: dominio, inicio: agora, ultimoAcesso: agora)
            sessoesAtivas[dominio] = novaSessao
        }
    }

    private func verificarInatividade() {
        let agora = Date()
        let inativos = sessoesAtivas.filter { agora.timeIntervalSince($1.ultimoAcesso) > tempoInatividade }

        for (dominio, sessao) in inativos {
            sessoesEncerradas.append(sessao)
            sessoesAtivas.removeValue(forKey: dominio)
            print("Sessão encerrada: \(dominio) - duração: \(Int(sessao.duracao)) segundos")
        }

        salvarRelatorioLocal()
    }

    private func salvarRelatorioLocal() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        if let data = try? encoder.encode(sessoesEncerradas) {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                .appendingPathComponent("relatorio_sessoes.json")
            try? data.write(to: url)
        }
    }

    func carregarRelatorios() -> [UseSessionModel] {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            .appendingPathComponent("relatorio_sessoes.json")
        if let data = try? Data(contentsOf: url),
           let sessoes = try? JSONDecoder().decode([UseSessionModel].self, from: data) {
            return sessoes
        }
        return []
    }
}

