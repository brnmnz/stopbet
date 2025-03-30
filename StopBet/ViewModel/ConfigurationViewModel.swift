import SwiftUI

class ConfigurationViewModel: ObservableObject {
    @Published var nome1: String = ""
    @Published var email1: String = ""

    @Published var nome2: String = ""
    @Published var email2: String = ""

    @Published var mostrarCampoExtra: Bool = false
    @Published var mostrarMensagem = false
    @Published var mensagemFeedback: String?

    private let userDefaultsKey = "redeDeApoioContatos"
    @Published private(set) var contatosSalvos: [ContactModel] = []

    var botaoHabilitado: Bool {
        let contato1Valido = nome1.trimmingCharacters(in: .whitespaces).count >= 2 &&
                             email1.isValidEmail()

        let contato2Valido = !mostrarCampoExtra || (
            nome2.trimmingCharacters(in: .whitespaces).count >= 2 &&
            email2.isValidEmail()
        )

        let contatosAtuais: [ContactModel] = [
            ContactModel(nome: nome1, email: email1),
            mostrarCampoExtra ? ContactModel(nome: nome2, email: email2) : nil
        ].compactMap { $0 }

        return contato1Valido && contato2Valido && contatosAtuais != contatosSalvos
    }

    func salvarContatos() {
        let contatos: [ContactModel] = [
            ContactModel(nome: nome1, email: email1),
            mostrarCampoExtra ? ContactModel(nome: nome2, email: email2) : nil
        ].compactMap { $0 }

        if let data = try? JSONEncoder().encode(contatos) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
            contatosSalvos = contatos
            mensagemFeedback = "Contatos salvos com sucesso!"
            mostrarMensagemTemporaria()
        }
    }

    func carregarContatos() {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let contatos = try? JSONDecoder().decode([ContactModel].self, from: data) else { return }

        contatosSalvos = contatos

        if contatos.indices.contains(0) {
            nome1 = contatos[0].nome
            email1 = contatos[0].email
        }

        if contatos.indices.contains(1) {
            nome2 = contatos[1].nome
            email2 = contatos[1].email
            mostrarCampoExtra = true
        }
    }

    func removerContatos() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        nome1 = ""
        email1 = ""
        nome2 = ""
        email2 = ""
        mostrarCampoExtra = false
        contatosSalvos = []

        mensagemFeedback = "Contatos removidos com sucesso!"
        mostrarMensagemTemporaria()
    }

    private func mostrarMensagemTemporaria() {
        mostrarMensagem = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.mostrarMensagem = false
        }
    }
}

extension String {
    func isValidEmail() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.count >= 5 &&
               trimmed.contains("@") &&
               trimmed.contains(".")
    }
}
