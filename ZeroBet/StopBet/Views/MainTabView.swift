import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // Aba Início
            NavigationStack {
                HomeView()
                    .navigationTitle("Início")
            }
            .tabItem {
                Label("Início", systemImage: "house.fill")
            }

            // Aba Blog
            NavigationStack {
                BlogSectionView()
                    .navigationTitle("Blog")
            }
            .tabItem {
                Label("Blog", systemImage: "book.fill")
            }

            // Aba Configurações
            NavigationStack {
                ConfiguracoesView()
                    .navigationTitle("Configurações")
            }
            .tabItem {
                Label("Configurações", systemImage: "gear")
            }
        }
        .accentColor(.orange)
    }
}
