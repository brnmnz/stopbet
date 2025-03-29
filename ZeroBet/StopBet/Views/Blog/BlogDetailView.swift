import SwiftUI

struct BlogDetailView: View {
    let post: BlogModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: post.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .clipped()
                
                Text(post.titulo)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)

                Text(post.conteudo + "\n\n(Conteúdo completo viria aqui...)")
                    .font(.body)
                    .foregroundColor(.primary)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Artigo")
        .navigationBarTitleDisplayMode(.inline)
    }
}
