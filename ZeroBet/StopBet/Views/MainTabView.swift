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
                    .navigationTitle("Blog")
                    //.navigationBarHidden(true)
            }
            .tabItem {
                Label("Blog", systemImage: "book.fill")
            }

            // Aba Configurações
            NavigationStack {
                ConfigurationView()
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
