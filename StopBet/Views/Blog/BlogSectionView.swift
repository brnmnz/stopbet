import SwiftUI

struct BlogSectionView: View {
    @StateObject private var viewModel = BlogViewModel()

    var body: some View {
        ZStack {
            
            GlowingBackgroundUtils() 
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(viewModel.artigos) { artigo in
                        NavigationLink(destination: BlogDetailView(post: artigo)) {
                            VStack(alignment: .leading, spacing: 8) {
                                AsyncImage(url: URL(string: artigo.image)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(height: 200)
                                .clipped()
                                
                                Text(artigo.titulo)
                                    .font(.headline)
                                    .foregroundColor(.orange)

                                Text(artigo.conteudo)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .onAppear {
                viewModel.carregarArtigosMock()
            }
        }
    }
}
