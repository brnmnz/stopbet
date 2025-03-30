import SwiftUI

struct ReportsView: View {
    let sessions = SessionMonitorService.shared.carregarRelatorios()

    var body: some View {
        List(sessions) { sessions in
            VStack(alignment: .leading) {
                Text(sessions.dominio)
                    .font(.headline)
                Text("Início: \(sessions.inicio.formatted())")
                Text("Duração: \(Int(sessions.duracao)) segundos")
            }
            .padding(.vertical, 8)
        }
        .navigationTitle("Relatórios de Uso")
    }
}
