import SwiftUI

struct ConfiguracoesView: View {
    @State private var nome1: String = ""
    @State private var email1: String = ""

    @State private var nome2: String = ""
    @State private var email2: String = ""

    @State private var mostrarCampoExtra: Bool = false
    @State private var mostrarMensagem = false
    @State private var mensagemFeedback: String?

    private let userDefaultsKey = "redeDeApoioContatos"
    @State private var contatosSalvos: [Contato] = []

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                if let mensagem = mensagemFeedback, mostrarMensagem {
                    Text(mensagem)
                        .font(.footnote)
                        .foregroundColor(.green)
                        .padding(.horizontal)
                        .transition(.opacity)
                        .animation(.easeInOut, value: mostrarMensagem)
                }

                Text("Rede de Apoio")
                    .font(.title2)
                    .bold()

                Text("Adicione pessoas da sua confiança para serem notificadas ou acompanharem seu progresso.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                // 🔹 Primeiro contato
                VStack(alignment: .leading, spacing: 10) {
                    TextField("Nome", text: $nome1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Email", text: $email1)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }

                // 🔸 Segundo contato (com botão de remover)
                if mostrarCampoExtra {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Contato adicional")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            Button(action: {
                                nome2 = ""
                                email2 = ""
                                mostrarCampoExtra = false
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }

                        TextField("Nome adicional", text: $nome2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        TextField("Email adicional", text: $email2)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    .padding(.top, 10)
                }

                // Botão para adicionar segundo contato
                if !mostrarCampoExtra {
                    Button(action: {
                        mostrarCampoExtra = true
                    }) {
                        Text("Adicionar outro contato")
                            .foregroundColor(.blue)
                    }
                }

                // Botão salvar
                Button(action: salvarContatos) {
                    Text("Salvar Contatos")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(botaoHabilitado ? Color.orange : Color.gray)
                        .cornerRadius(12)
                }
                .padding(.top)
                .disabled(!botaoHabilitado)

                // Botão remover todos
                Button(role: .destructive) {
                    removerContatos()
                } label: {
                    Text("Remover todos os contatos")
                        .frame(maxWidth: .infinity)
                }
                .padding(.top, 4)

                Spacer()
            }
            .padding()
            .navigationTitle("Configurações")
            .onAppear(perform: carregarContatos)
        }
    }

    // MARK: - Validação do botão

    var botaoHabilitado: Bool {
        let contato1Valido = nome1.trimmingCharacters(in: .whitespaces).count >= 2 &&
                             email1.isValidEmail()

        let contato2Valido = !mostrarCampoExtra || (
            nome2.trimmingCharacters(in: .whitespaces).count >= 2 &&
            email2.isValidEmail()
        )

        let contatosAtuais: [Contato] = [
            Contato(nome: nome1, email: email1),
            mostrarCampoExtra ? Contato(nome: nome2, email: email2) : nil
        ].compactMap { $0 }

        let diferenteDoSalvo = contatosAtuais != contatosSalvos

        return contato1Valido && contato2Valido && diferenteDoSalvo
    }

    // MARK: - Funções

    func salvarContatos() {
        let contatos: [Contato] = [
            Contato(nome: nome1, email: email1),
            mostrarCampoExtra ? Contato(nome: nome2, email: email2) : nil
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
              let contatos = try? JSONDecoder().decode([Contato].self, from: data) else { return }

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

    func mostrarMensagemTemporaria() {
        withAnimation {
            mostrarMensagem = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            withAnimation {
                mostrarMensagem = false
            }
        }
    }
}

// MARK: - Validação de e-mail

extension String {
    func isValidEmail() -> Bool {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.count >= 5 && trimmed.contains("@") && trimmed.contains(".")
    }
}
