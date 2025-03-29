import SwiftUI

struct BlogSectionView: View {
    @StateObject private var viewModel = BlogViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // 👉 Novo card horizontal
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: UIScreen.main.bounds.width / 2, height: 120)
                    .overlay(
                        Text("Destaque 1")
                            .foregroundColor(.white)
                            .bold()
                    )

                Rectangle()
                    .fill(Color.red)
                    .frame(width: UIScreen.main.bounds.width / 2, height: 120)
                    .overlay(
                        Text("Destaque 2")
                            .foregroundColor(.white)
                            .bold()
                    )
            }

            // 👉 Lista vertical de artigos
            ForEach(viewModel.artigos) { artigo in
                NavigationLink(destination: BlogDetailView(post: artigo)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(artigo.titulo)
                            .font(.headline)
                            .foregroundColor(.orange)
                        Text(artigo.conteudo)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            viewModel.carregarArtigosMock()
        }
    }
}
