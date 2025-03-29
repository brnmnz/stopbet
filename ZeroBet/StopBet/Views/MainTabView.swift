import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // Aba Início
            NavigationStack {
                HomeView()
                    .navigationBarHidden(true)
                    //.navigationTitle("Início")
            }
            .tabItem {
                Label("Início", systemImage: "house.fill")
            }

            // Aba Blog
            NavigationStack {
                BlogSectionView()
                    .navigationBarHidden(true)
                    //.navigationTitle("Blog")
            }
            .tabItem {
                Label("Blog", systemImage: "book.fill")
            }

            // Aba Configurações
            NavigationStack {
                ConfiguracoesView()
                    .navigationBarHidden(true)
                    //.navigationTitle("Configurações")
            }
            .tabItem {
                Label("Rede de Apoio", systemImage: "person.3.fill")
            }
        }
        .accentColor(.orange)
    }
}
