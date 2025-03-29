import Foundation

class BlogViewModel: ObservableObject {
    @Published var artigos: [BlogPost] = []

    init() {
        carregarArtigosMock() // Pode trocar por chamada de API depois
    }

    func carregarArtigosMock() {
        artigos = [
            BlogPost(id: 1, titulo: "5 Dicas para Evitar o Vício em Apostas", conteudo: "Evitar recaídas exige foco, suporte e ferramentas práticas..."),
            BlogPost(id: 2, titulo: "Como Substituir o Hábito de Apostar", conteudo: "Trocar o hábito por algo saudável é uma das chaves..."),
            BlogPost(id: 3, titulo: "Entenda o Efeito das Apostas no Cérebro", conteudo: "O vício em jogos tem base neuroquímica. Descubra como isso afeta sua mente...")
        ]
    }
}
