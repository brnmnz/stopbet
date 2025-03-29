import SwiftUI

struct SplashScreenView: View {
    @State private var showContent = false
    @State private var navigateToMain = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "shield.lefthalf.fill") 
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.orange)
                    .scaleEffect(showContent ? 1 : 0.6)
                    .opacity(showContent ? 1 : 0)

                Text("StopBet")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(.orange)
                    .opacity(showContent ? 1 : 0)
                    .scaleEffect(showContent ? 1 : 0.8)
            }
            .animation(.easeOut(duration: 1), value: showContent)
        }
        .onAppear {
            showContent = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                navigateToMain = true
            }
        }
        .fullScreenCover(isPresented: $navigateToMain) {
            MainTabView()
                .preferredColorScheme(.dark) // caso você queira reforçar modo escuro na próxima tela
        }
    }
}
