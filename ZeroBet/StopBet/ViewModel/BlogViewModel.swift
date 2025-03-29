import Foundation

class BlogViewModel: ObservableObject {
    @Published var artigos: [BlogPost] = []

    init() {
        carregarArtigosMock() 
    }

    func carregarArtigosMock() {
        artigos = [
            BlogPost(image: "https://c0.wallpaperflare.com/preview/144/715/662/nature-water-sea-ocean.jpg", id: 1, titulo: "5 Dicas para Evitar o Vício em Apostas", conteudo: "Evitar recaídas exige foco, suporte e ferramentas práticas..."),
            BlogPost(image: "https://c0.wallpaperflare.com/preview/144/715/662/nature-water-sea-ocean.jpg", id: 2, titulo: "Como Substituir o Hábito de Apostar", conteudo: "Trocar o hábito por algo saudável é uma das chaves..."),
            BlogPost(image: "https://c0.wallpaperflare.com/preview/144/715/662/nature-water-sea-ocean.jpg", id: 3, titulo: "Entenda o Efeito das Apostas no Cérebro", conteudo: "O vício em jogos tem base neuroquímica. Descubra como isso afeta sua mente...")
        ]
    }
}
