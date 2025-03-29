import SwiftUI

struct SplashScreenView: View {
    @State private var showText = false
    @State private var navigateToWelcome = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            Text("StopBet")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundColor(.orange)
                .opacity(showText ? 1 : 0)
                .scaleEffect(showText ? 1 : 0.8)
                .animation(.easeIn(duration: 1), value: showText)
        }
        .onAppear {
            showText = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                navigateToWelcome = true
            }
        }
        .fullScreenCover(isPresented: $navigateToWelcome) {
            MainTabView()
        }
    }
}
