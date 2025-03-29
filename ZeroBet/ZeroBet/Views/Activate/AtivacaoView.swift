import SwiftUI

struct AtivacaoView: View {
    @StateObject private var viewModel = AtivacaoViewModel()

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            if viewModel.perfilInstalado {
                Image(systemName: "checkmark.shield.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.green)

                Text("Monitoramento ativado com sucesso!")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button("Desativar Monitoramento") {
                    viewModel.desativarMonitoramento()
                }

            } else {
                Text("Monitorar sites acessados no Safari")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)

                Button("Ativar Monitoramento") {
                    viewModel.ativarMonitoramento()
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(16)
            }

            Spacer()
        }
        .padding()
    }
}
