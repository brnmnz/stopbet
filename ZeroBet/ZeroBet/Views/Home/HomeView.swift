import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 30) {
                    Image(systemName: "shield.lefthalf.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.orange)

                    Text("Você está no controle.")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    Text("Ative sua proteção contra apostas e mantenha seu foco.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 40)

                    NavigationLink(destination: AtivacaoView()) {
                        Text("Ativar Proteção")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                            .padding(.horizontal, 40)
                    }
                }
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height,
                    alignment: .center
                )
            }
        }
    }
}
