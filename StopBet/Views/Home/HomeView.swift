import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = AtivacaoViewModel()
    @State private var progress: CGFloat = 0.0
    @State private var isLoading = false
    @State private var timer: Timer?

    let activationDuration: TimeInterval = 1.5

    var body: some View {
        ZStack {
            GlowingBackgroundUtils()

            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        Spacer()

                        VStack(spacing: 30) {
                            Image(systemName: viewModel.perfilInstalado ? "checkmark.shield.fill" : "shield.lefthalf.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(viewModel.perfilInstalado ? .green : .orange)

                            Text(viewModel.perfilInstalado ? "Monitoramento Ativado" : "Você está no controle.")
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.horizontal)

                            Text(viewModel.perfilInstalado
                                 ? "O bloqueio de sites de apostas está ativo no Safari."
                                 : "Ative sua proteção contra apostas e mantenha seu foco.")
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 40)

                            if viewModel.perfilInstalado {
                                Button("Desativar Monitoramento") {
                                    viewModel.desativarMonitoramento()
                                }
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .foregroundColor(.red)
                                .cornerRadius(16)
                                .padding(.horizontal, 40)
                            } else {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.orange.opacity(0.2))
                                        .frame(height: 50)
                                        .overlay(
                                            GeometryReader { geo in
                                                RoundedRectangle(cornerRadius: 16)
                                                    .fill(Color.orange)
                                                    .frame(width: geo.size.width * progress)
                                                    .animation(.linear(duration: 0.1), value: progress)
                                            }
                                        )

                                    Text(isLoading ? "Ativando..." : "Segure para Ativar")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, 40)
                                .gesture(
                                    DragGesture(minimumDistance: 0)
                                        .onChanged { _ in
                                            if !isLoading {
                                                startProgress()
                                            }
                                        }
                                        .onEnded { _ in
                                            cancelProgress()
                                        }
                                )
                            }
                        }

                        Spacer()
                    }
                    .frame(minHeight: geometry.size.height) // 👉 força ocupar a tela toda
                    .frame(maxWidth: .infinity)
                    .padding()
                }
            }
        }
        .alert(item: $viewModel.mensagemErro) { erro in
            Alert(title: Text("Erro"),
                  message: Text(erro.mensagem),
                  dismissButton: .default(Text("OK")) {
                      viewModel.mensagemErro = nil
                  })
        }
    }

    // MARK: - Progresso controlado com Timer

    func startProgress() {
        isLoading = true
        progress = 0.0

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { t in
            progress += 0.05 / activationDuration

            if progress >= 1.0 {
                t.invalidate()
                completeActivation()
            }
        }
    }

    func cancelProgress() {
        if progress < 1.0 {
            timer?.invalidate()
            progress = 0.0
            isLoading = false
        }
    }

    func completeActivation() {
        isLoading = false
        progress = 0.0
        viewModel.ativarMonitoramento()
    }
}
