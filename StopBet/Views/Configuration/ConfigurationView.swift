import SwiftUI

struct ConfigurationView: View {
    @StateObject private var viewModel = ConfigurationViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                GlowingBackgroundUtils() // 🔥 fundo fica por trás de tudo

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if let msg = viewModel.mensagemFeedback, viewModel.mostrarMensagem {
                            Text(msg)
                                .font(.footnote)
                                .foregroundColor(.green)
                                .padding(.horizontal)
                                .transition(.opacity)
                        }

                        Text("Rede de Apoio")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)

                        Text("Adicione pessoas da sua confiança para serem notificadas ou acompanharem seu progresso.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        // Primeiro contato
                        VStack {
                            TextField("Nome", text: $viewModel.nome1)
                            TextField("Email", text: $viewModel.email1)
                                .keyboardType(.emailAddress)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                        // Segundo contato
                        if viewModel.mostrarCampoExtra {
                            VStack {
                                HStack {
                                    Text("Contato adicional")
                                    Spacer()
                                    Button {
                                        viewModel.nome2 = ""
                                        viewModel.email2 = ""
                                        viewModel.mostrarCampoExtra = false
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                                TextField("Nome adicional", text: $viewModel.nome2)
                                TextField("Email adicional", text: $viewModel.email2)
                                    .keyboardType(.emailAddress)
                            }
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        } else {
                            Button("Adicionar outro contato") {
                                viewModel.mostrarCampoExtra = true
                            }
                            .foregroundColor(.blue)
                        }

                        Button("Salvar Contatos") {
                            viewModel.salvarContatos()
                        }
                        .disabled(!viewModel.botaoHabilitado)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(viewModel.botaoHabilitado ? Color.orange : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)

                        Button("Remover todos os contatos", role: .destructive) {
                            viewModel.removerContatos()
                        }

                        Spacer(minLength: 20)
                    }
                    .padding()
                }
            }
            .navigationTitle("Configurações")
            .onAppear {
                viewModel.carregarContatos()
            }
        }
    }
}
